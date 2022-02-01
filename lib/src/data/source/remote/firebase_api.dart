import 'package:artitecture/src/core/global.dart';
import 'package:artitecture/src/core/resources/data_error.dart';
import 'package:artitecture/src/core/resources/error_code.dart';
import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/core/utils/constants.dart';
import 'package:artitecture/src/core/utils/platforms.dart';
import 'package:artitecture/src/data/source/extension/firebase_extension.dart';
import 'package:artitecture/src/domain/entity/param/update_profile_param.dart';
import 'package:artitecture/src/domain/entity/response/app_version.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/domain/entity/response/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:logger/logger.dart';

class FirebaseApi {
  final Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  Future<bool> isSigned() async {
    return auth.currentUser?.uid != null;
  }

  Future<ResultWrapper> signUp(String email, String password) async {
    try {
      Auth.UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      Logger().d("signUp success = ${userCredential.toString()}");
      await fireStore.collection(kUserCollectionKey).doc(userCredential.user?.uid).set({
        "email": userCredential.user?.email,
        "profile_url": userCredential.user?.photoURL
      });
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
      Auth.UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
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
      await auth.sendPasswordResetEmail(email: email);
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
      await auth.signInWithCredential(credential);
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
      final userDocument = await fireStore.collection(kUserCollectionKey).doc(auth.currentUser?.uid).get();
      final categories = await fireStore.collection(kUserCategoryCollectionKey).where('user_id', isEqualTo: auth.currentUser?.uid).get();
      final user = userDocument.toUser(auth.currentUser?.uid, categories.docs.map((e) => e.toCategory()).toList());
      Logger().d("user = $user");
      return Success(user);
    } on FirebaseException catch (e) {
      Logger().d("getUser exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper> updateProfile(UpdateProfileParam param) async {
    try {
      final checkNickname = await fireStore.collection(kUserCollectionKey).where('nickname', isEqualTo: param.nickname).get();
      if (checkNickname.docs.isNotEmpty) {
        return Failure(DataError(nicknameAlreadyInUseError, 'nickname is already in use'));
      }

      await fireStore.collection(kUserCollectionKey).doc(auth.currentUser?.uid).set({
        "nickname": param.nickname,
        "is_approved": true
      }, SetOptions(merge: true));
      for (var category in param.categories) {
        await fireStore.collection(kUserCategoryCollectionKey).add({
          "user_id": auth.currentUser?.uid,
          "category_id": category.id,
          "category_name": category.name
        });
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
      await auth.signOut();
      return true;
    } on Auth.FirebaseAuthException catch (e) {
      Logger().d("signOut exception = ${e.code}");
      return false;
    }
  }

  Future<ResultWrapper> secession() async {
    try {
      await auth.currentUser?.delete();
      return const Success(null);
    } on Auth.FirebaseAuthException catch (e) {
      Logger().d("signOut exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper<AppVersion>> getAppVersion() async {
    try {
      var document = await fireStore.collection(kAppVersionCollectionKey).doc(PlatformUtil.getPlatformName()).get();
      return Success(document.toAppVersion());
    } on Auth.FirebaseAuthException catch (e) {
      Logger().d("getAppVersion exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper<List<Category>>> getCategories() async {
    try {
      var document = await fireStore.collection(kCategoryCollectionKey).get();
      return Success(document.docs.map((e) => e.toCategory()).toList());
    } on Auth.FirebaseAuthException catch (e) {
      Logger().d("getCategories exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }
}