import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/response/user.dart';

abstract class AuthRepository {
  Future<bool> isSigned();
  Future<ResultWrapper> signUp(String email, String password);
  Future<ResultWrapper> signIn(String email, String password);
  Future<ResultWrapper> resetPassword(String email);
  Future<ResultWrapper> googleSignIn();
  Future<ResultWrapper<User?>> getUser();
  Future<bool> signOut();
  Future<ResultWrapper> secession();
}