import 'package:artitecture/src/domain/usecase/is_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_in_usecase.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final IsSignInUseCase isSignInUseCase;
  final SignInUseCase signInUseCase;

  AuthController(this.signInUseCase, this.isSignInUseCase);

  Future<bool> isSignIn() {
    return isSignInUseCase();
  }

  void signIn() {

  }

  void signUp() {

  }
}