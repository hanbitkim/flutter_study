import 'package:artitecture/src/core/resources/data_error.dart';
import 'package:artitecture/src/core/resources/error_code.dart';
import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/core/utils/constants.dart';
import 'package:artitecture/src/core/utils/platforms.dart';
import 'package:artitecture/src/domain/entity/response/app_version.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class FirebaseAuthApi {
  final FirebaseAuth auth;

  FirebaseAuthApi(this.auth);

  Future<bool> isSignIn() async {
    return auth.currentUser?.uid != null;
  }

  Future<ResultWrapper> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      Logger().d("signUp success = ${userCredential.toString()}");
      return const Success(null);
    } on FirebaseAuthException catch (e) {
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
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      Logger().d("signIn success = ${userCredential.toString()}");
      return const Success(null);
    } on FirebaseAuthException catch (e) {
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
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return const Success(null);
    } on FirebaseAuthException catch (e) {
      Logger().d("resetPassword exception = ${e.code}");
      if (e.code == 'user-not-found') {
        return Failure(DataError(userNotFoundError, e.code));
      }
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper> googleSignIn(String? accessToken, String? idToken) async {
    try {
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return const Success(null);
    } on FirebaseAuthException catch (e) {
      Logger().d("resetPassword exception = ${e.code}");
      if (e.code == 'user-not-found') {
        return Failure(DataError(userNotFoundError, e.code));
      }
      return Failure(DataError(error, e.code));
    }
  }

  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      Logger().d("signOut exception = ${e.code}");
      return false;
    }
  }

  Future<ResultWrapper> secession() async {
    try {
      await FirebaseAuth.instance.currentUser?.delete();
      return const Success(null);
    } on FirebaseAuthException catch (e) {
      Logger().d("signOut exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }

  Future<ResultWrapper<AppVersion>> getAppVersion() async {
    try {
      var document = await FirebaseFirestore.instance.collection(kAppVersionCollectionKey).doc(PlatformUtil.getPlatformName()).get();
      return Success(AppVersion.fromDocument(document));
    } on FirebaseAuthException catch (e) {
      Logger().d("getAppVersion exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }
}