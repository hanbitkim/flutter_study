import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/data/source/remote/firebase_auth_api.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';

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
}