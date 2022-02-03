import 'dart:io';

import 'package:artitecture/src/core/global.dart';
import 'package:artitecture/src/core/resources/data_error.dart';
import 'package:artitecture/src/core/resources/error_code.dart';
import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/core/utils/constants.dart';
import 'package:artitecture/src/core/utils/platforms.dart';
import 'package:artitecture/src/data/source/extension/firebase_extension.dart';
import 'package:artitecture/src/domain/entity/param/update_profile_param.dart';
import 'package:artitecture/src/domain/entity/param/upload_article_param.dart';
import 'package:artitecture/src/domain/entity/response/app_version.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/domain/entity/response/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class FirebaseApi {
  final Auth.FirebaseAuth _auth = Auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<bool> isSigned() async {
    return _auth.currentUser?.uid != null;
  }

  Future<ResultWrapper> signUp(String email, String password) async {
    try {
      Auth.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Logger().d("signUp success = ${userCredential.toString()}");
      await _firestore.collection(kUserCollectionKey).doc(userCredential.user?.uid).set({"email": userCredential.user?.email, "profile_url": userCredential.user?.photoURL});
      return const Success(null);
    } on FirebaseException catch (e) {
      Logger().d("signUp exception = ${e.code}");
      if (e.code == 'weak-password') {
        return Failure(DataError(weekPasswordError, e.code));
      } else if (e.code == 'email-already-in-use') {
        return Failure(DataError(emailAlreadyInUseError, e.code));
      }
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper> signIn(String email, String password) async {
    try {
      Auth.UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      Logger().d("signIn success = ${userCredential.toString()}");
      return const Success(null);
    } on Auth.FirebaseAuthException catch (e) {
      Logger().d("signIn exception = ${e.code}");
      if (e.code == 'user-not-found') {
        return Failure(DataError(userNotFoundError, e.code));
      } else if (e.code == 'wrong-password') {
        return Failure(DataError(wrongPasswordError, e.code));
      }
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Success(null);
    } on Auth.FirebaseAuthException catch (e) {
      Logger().d("resetPassword exception = ${e.code}");
      if (e.code == 'user-not-found') {
        return Failure(DataError(userNotFoundError, e.code));
      }
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper> googleSignIn(String? accessToken, String? idToken) async {
    try {
      final Auth.AuthCredential credential = Auth.GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      await _auth.signInWithCredential(credential);
      return const Success(null);
    } on Auth.FirebaseAuthException catch (e) {
      Logger().d("resetPassword exception = ${e.code}");
      if (e.code == 'user-not-found') {
        return Failure(DataError(userNotFoundError, e.code));
      }
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper<User?>> getUser() async {
    try {
      final userDocument = await _firestore.collection(kUserCollectionKey).doc(_auth.currentUser?.uid).get();
      final categories = await _firestore.collection(kUserCategoryCollectionKey).where('user_id', isEqualTo: _auth.currentUser?.uid).get();
      final user = userDocument.toUser(_auth.currentUser?.uid, categories.docs.map((e) => e.toCategory()).toList());
      Logger().d("user = $user");
      return Success(user);
    } on FirebaseException catch (e) {
      Logger().d("getUser exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper> updateProfile(UpdateProfileParam param) async {
    try {
      final checkNickname = await _firestore.collection(kUserCollectionKey).where('nickname', isEqualTo: param.nickname).get();
      if (checkNickname.docs.isNotEmpty) {
        return Failure(DataError(nicknameAlreadyInUseError, 'nickname is already in use'));
      }

      await _firestore.collection(kUserCollectionKey).doc(_auth.currentUser?.uid).set({"nickname": param.nickname, "is_approved": true}, SetOptions(merge: true));
      for (var category in param.categories) {
        await _firestore.collection(kUserCategoryCollectionKey).add({"user_id": _auth.currentUser?.uid, "category_id": category.id, "category_name": category.name});
        user.value = user.value?.copyWith(categories: param.categories);
      }
      return const Success(null);
    } on FirebaseException catch (e) {
      Logger().d("updateProfile exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } on Auth.FirebaseAuthException catch (e) {
      Logger().d("signOut exception = ${e.code}");
      return false;
    }
  }

  Future<ResultWrapper> secession() async {
    try {
      await _auth.currentUser?.delete();
      return const Success(null);
    } on FirebaseException catch (e) {
      Logger().d("signOut exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper<AppVersion>> getAppVersion() async {
    try {
      var document = await _firestore.collection(kAppVersionCollectionKey).doc(PlatformUtil.getPlatformName()).get();
      return Success(document.toAppVersion());
    } on FirebaseException catch (e) {
      Logger().d("getAppVersion exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper<List<Category>>> getCategories() async {
    try {
      final document = await _firestore.collection(kCategoryCollectionKey).get();
      return Success(document.docs.map((e) => e.toCategory()).toList());
    } on FirebaseException catch (e) {
      Logger().d("getCategories exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper<List<Article>>> getArticles(String? categoryId, int? lastArticleDate) async {
    try {
      List<Article> articles = List.empty(growable: true);
      final document = await _firestore.collection(kArticleCollectionKey).where('category_id', isEqualTo: categoryId).where('created_date', isLessThan: lastArticleDate).limit(kPageSize).get();
      for (DocumentSnapshot articleDocument in document.docs) {
        final imageCollection = await articleDocument.reference.collection('image').get();
        final authorDocument = await _firestore.collection(kUserCollectionKey).doc(articleDocument.getSafety('author_id')).get();
        articles.add(articleDocument.toArticle(imageCollection.docs.map((e) => e.toImage()).toList(), authorDocument.toAuthor()));
      }
      return Success(articles);
    } on FirebaseException catch (e) {
      Logger().d("getCategories exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper> uploadArticle(UploadArticleParam param) async {
    try {
      List<String> images = List.empty(growable: true);
      for (String path in param.images) {
        File file = File(path);
        String fileName = basename(file.path);
        Reference ref = _storage.ref().child('article_image').child(fileName);
        UploadTask uploadTask = ref.putFile(file);
        TaskSnapshot taskSnapshot = await uploadTask;
        String url = await taskSnapshot.ref.getDownloadURL();
        Logger().d('uploaded image = $url');
        images.add(url);
      }
      DocumentReference articleRef = await _firestore.collection(kArticleCollectionKey).add({
        "category_id": param.categoryId,
        "title": param.title,
        "contents": param.contents,
        "author_id": user.value?.id,
        "created_date": DateTime.now().millisecond
      });
      await _firestore.collection(kArticleCollectionKey).doc(articleRef.id).set({"article_id": articleRef.id}, SetOptions(merge: true));
      for (String path in images) {
        DocumentReference imageRef = await _firestore.collection(kArticleCollectionKey).doc(articleRef.id).collection('image').add({
          "image_url": path
        });
        await _firestore.collection(kArticleCollectionKey).doc(articleRef.id).collection('image').doc(imageRef.id).set({"image_id": imageRef.id}, SetOptions(merge: true));
      }
      return const Success(null);
    } on FirebaseException catch (e) {
      Logger().d("uploadArticle exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }
}
