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
  Future<void> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }
}