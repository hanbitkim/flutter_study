abstract class AuthRepository {
  Future<bool> isSignIn();
  Future<void> signIn();
}