import 'package:artitecture/src/domain/usecase/is_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_up_usecase.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final IsSignInUseCase isSignInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;

  AuthController(this.signInUseCase, this.signUpUseCase, this.isSignInUseCase);

  final isLogging = RxBool(false);
  final isSigning = RxBool(false);

  Future<bool> isSignIn() {
    return isSignInUseCase();
  }

  void signIn(String email, String password) async {
    if (check(email, password)) {
      isLogging.value = true;
      var result = await signInUseCase(email, password);
      if (result.isSuccess()) {
        Get.offNamed(mainRoute);
      } else {
        Get.snackbar("로그인에 실패하였습니다", "이메일과 비밀번호를 확인해주세요");
      }
      isLogging.value = false;
    }
  }

  void signUp(String email, String password) async {
    if (check(email, password)) {
      isSigning.value = true;
      var result = await signUpUseCase(email, password);
      if (result.isSuccess()) {
        Get.offAllNamed(mainRoute);
      } else {
        Get.snackbar("가입에 실패하였습니다", "이메일과 비밀번호를 확인해주세요");
      }
      isSigning.value = false;
    }
  }

  bool check(String email, String password) {
    if (!EmailValidator.validate(email)) {
      Get.snackbar("올바른 이메일 형식이 아닙니다", "이메일 주소를 다시 입력해주세요");
      return false;
    }
    if (password.isEmpty) {
      Get.snackbar("올바른 비밀번호 형식이 아닙니다", "비밀번호를 다시 입력해주세요");
      return false;
    }

    return true;
  }
}