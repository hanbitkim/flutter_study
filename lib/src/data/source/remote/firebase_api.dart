import 'dart:io';

import 'package:artitecture/src/core/global.dart';
import 'package:artitecture/src/core/resources/data_error.dart';
import 'package:artitecture/src/core/resources/error_code.dart';
import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/core/utils/constants.dart';
import 'package:artitecture/src/core/utils/platforms.dart';
import 'package:artitecture/src/data/source/extension/firebase_extension.dart';
import 'package:artitecture/src/data/source/remote/result_handler.dart';
import 'package:artitecture/src/domain/entity/param/update_profile_param.dart';
import 'package:artitecture/src/domain/entity/param/upload_article_param.dart';
import 'package:artitecture/src/domain/entity/response/app_version.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/domain/entity/response/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';

class FirebaseApi {
  final Auth.FirebaseAuth _auth = Auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<bool> isSigned() async {
    return _auth.currentUser?.uid != null;
  }

  Future<ResultWrapper> signUp(String email, String password) async {
    try {
      Auth.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Logger().d("signUp success = ${userCredential.toString()}");
      await _firestore.collection(kUserCollectionKey).doc(userCredential.user?.uid).set({"email": userCredential.user?.email, "profile_url": userCredential.user?.photoURL, "created_date": FieldValue.serverTimestamp()});
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
    return ResultHandler<User?>().invoke(() async {
      final userDocument = await _firestore.collection(kUserCollectionKey).doc(_auth.currentUser?.uid).get();
      final token = await _messaging.getToken();
      userDocument.reference.set({"push_token": token}, SetOptions(merge: true));
      final categories = await _firestore.collection(kUserCategoryCollectionKey).where('user_id', isEqualTo: _auth.currentUser?.uid).get();
      return userDocument.toUser(categories.docs.map((e) => e.toCategory()).toList());
    });
  }

  Future<ResultWrapper> updateProfile(UpdateProfileParam param) async {
    return ResultHandler().invoke(() async {
      final checkNickname = await _firestore.collection(kUserCollectionKey).where('nickname', isEqualTo: param.nickname).get();
      if (checkNickname.docs.isNotEmpty) {
        return Failure(DataError(nicknameAlreadyInUseError, 'nickname is already in use'));
      }
      final token = await _messaging.getToken();
      WriteBatch writeBatch = _firestore.batch();
      writeBatch.set(_firestore.collection(kUserCollectionKey).doc(_auth.currentUser?.uid), {"nickname": param.nickname, "push_token": token, "is_approved": true}, SetOptions(merge: true));
      for (var category in param.categories) {
        final categoryDocument = _firestore.collection(kUserCategoryCollectionKey).doc();
        writeBatch.set(categoryDocument, {"user_id": _auth.currentUser?.uid, "category_id": category.id, "category_name": category.name});
      }
      await writeBatch.commit();
      user.value = user.value?.copyWith(categories: param.categories);
      return null;
    });
  }

  Future<ResultWrapper> updateProfileImage(String path) async {
    return ResultHandler().invoke(() async {
      String url = await uploadImage(path);
      _firestore.collection(kUserCollectionKey).doc(_auth.currentUser?.uid).set({"profile_url": url}, SetOptions(merge: true));
      user.value = user.value?.copyWith(profileUrl: url);
      return null;
    });
  }

  Future<ResultWrapper<bool>> signOut() async {
    return ResultHandler<bool>().invoke(() async {
      await _auth.signOut();
      return true;
    });
  }

  Future<ResultWrapper> secession() async {
    return ResultHandler().invoke(() async {
      await _auth.currentUser?.delete();
      return null;
    });
  }

  Future<ResultWrapper<AppVersion>> getAppVersion() async {
    return ResultHandler<AppVersion>().invoke(() async {
      var document = await _firestore.collection(kAppVersionCollectionKey).doc(PlatformUtil.getPlatformName()).get();
      return document.toAppVersion();
    });
  }

  Future<ResultWrapper<List<Category>>> getCategories() async {
    return ResultHandler<List<Category>>().invoke(() async {
      final document = await _firestore.collection(kCategoryCollectionKey).get();
      return document.docs.map((e) => e.toCategory()).toList();
    });
  }

  Future<ResultWrapper<List<Article>>> getArticles(String? categoryId, int? lastArticleDate) async {
    return ResultHandler<List<Article>>().invoke(() async {
      List<Article> articles = List.empty(growable: true);
      final document = await _firestore.collection(kArticleCollectionKey).where('category_id', isEqualTo: categoryId).where('created_date', isLessThan: lastArticleDate).orderBy("created_date", descending: true).limit(kPageSize).get();
      for (DocumentSnapshot articleDocument in document.docs) {
        final imageCollection = await articleDocument.reference.collection('image').orderBy("index").get();
        final authorDocument = await _firestore.collection(kUserCollectionKey).doc(articleDocument.getSafety('author_id')).get();
        articles.add(articleDocument.toArticle(imageCollection.docs.map((e) => e.toImage()).toList(), authorDocument.toAuthor()));
      }
      return articles;
    });
  }

  Future<ResultWrapper> uploadArticle(UploadArticleParam param) async {
    return ResultHandler().invoke(() async {
      List<String> images = List.empty(growable: true);
      for (String path in param.images) {
        String url = await uploadImage(path);
        Logger().d('uploaded image = $url');
        images.add(url);
      }
      final articleDocument = _firestore.collection(kArticleCollectionKey).doc();
      WriteBatch writeBatch = _firestore.batch();
      writeBatch.set(articleDocument, {
        "article_id": articleDocument.id,
        "category_id": param.categoryId,
        "title": param.title,
        "contents": param.contents,
        "author_id": user.value?.id,
        "created_date": FieldValue.serverTimestamp()
      });
      for (int i = 0; i < images.length; i++) {
        final imageDocument = articleDocument.collection('image').doc();
        writeBatch.set(imageDocument, {
          "index": i,
          "image_id": imageDocument.id,
          "image_url": images[i]
        });
      }
      await writeBatch.commit();
      return null;
    });
  }

  Future<ResultWrapper> updatePushToken(String token) async {
    return ResultHandler().invoke(() async {
      await _firestore.collection(kUserCollectionKey).doc(_auth.currentUser?.uid).set({"push_token": token}, SetOptions(merge: true));
      return null;
    });
  }

  Future<String> uploadImage(String path) async {
    File file = File(path);
    String fileName = basename(path);
    Reference ref = _storage.ref().child('profile_image').child(fileName);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}
