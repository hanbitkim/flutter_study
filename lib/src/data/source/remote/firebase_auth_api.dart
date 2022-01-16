import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthApi {
  final FirebaseAuth auth;

  FirebaseAuthApi(this.auth);

  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

}