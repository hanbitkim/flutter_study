import 'package:artitecture/src/core/resources/result_wrapper.dart';

abstract class AuthRepository {
  Future<bool> isSignIn();
  Future<ResultWrapper> signUp(String email, String password);
  Future<ResultWrapper> signIn(String email, String password);
  Future<ResultWrapper> resetPassword(String email);
  Future<ResultWrapper> googleSignIn();
  Future<void> signOut();
}