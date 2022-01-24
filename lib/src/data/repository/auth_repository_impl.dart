import 'package:artitecture/src/core/resources/data_error.dart';
import 'package:artitecture/src/core/resources/error_code.dart';
import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/data/source/remote/firebase_auth_api.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuthApi firebaseAuthApi;

  AuthRepositoryImpl(this.firebaseAuthApi);

  @override
  Future<bool> isSignIn() {
    return firebaseAuthApi.isSignIn();
  }

  @override
  Future<ResultWrapper> signUp(String email, String password) {
    return firebaseAuthApi.signUp(email, password);
  }

  @override
  Future<ResultWrapper> signIn(String email, String password) {
    return firebaseAuthApi.signIn(email, password);
  }

  @override
  Future<ResultWrapper> resetPassword(String email) {
    return firebaseAuthApi.resetPassword(email);
  }

  @override
  Future<ResultWrapper> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) {
      return Failure(DataError(error, "failed to get google account"));
    }
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    return firebaseAuthApi.googleSignIn(googleSignInAuthentication.accessToken, googleSignInAuthentication.idToken);
  }

  @override
  Future<bool> signOut() async {
    return firebaseAuthApi.signOut();
  }

  @override
  Future<ResultWrapper> secession() {
    return firebaseAuthApi.secession();
  }
}