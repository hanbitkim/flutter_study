import 'package:artitecture/src/core/resources/error_code.dart';
import 'package:artitecture/src/domain/usecase/google_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/is_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/reset_password_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_up_usecase.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final IsSignInUseCase isSignInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final GoogleSignInUseCase googleSignInUseCase;

  AuthController(this.signInUseCase, this.signUpUseCase, this.isSignInUseCase, this.resetPasswordUseCase, this.googleSignInUseCase);

  final isLogging = RxBool(false);
  final isSigning = RxBool(false);

  Future<bool> isSignIn() {
    return isSignInUseCase();
  }

  void signIn(String email, String password) async {
    isLogging.value = true;
    var response = await signInUseCase(email, password);
    if (response.isSuccess()) {
      Get.offNamed(mainRoute);
    } else {
      Get.snackbar("로그인에 실패하였습니다", "이메일과 비밀번호를 확인해주세요");
    }
    isLogging.value = false;
  }

  void signUp(String email, String password) async {
    isSigning.value = true;
    var response = await signUpUseCase(email, password);
    if (response.isSuccess()) {
      Get.offAllNamed(mainRoute);
    } else {
      Get.snackbar("가입에 실패하였습니다", "이메일과 비밀번호를 확인해주세요");
    }
    isSigning.value = false;
  }

  void sendResetPasswordEmail(String email) async {
    var response = await resetPasswordUseCase(email);
    if (response.isSuccess()) {
      Get.back();
      Get.snackbar("이메일을 전송하였습니다", "메일을 확인해주세요");
    } else {
      if (response.error?.code == userNotFoundError) {
        Get.snackbar("가입된 이메일이 아닙니다", "이메일 주소를 확인해주세요");
      } else {
        Get.snackbar("에러가 발생했습니다", "네트워크 상태를 확인 후 다시 시도해주세요");
      }
    }
  }

  void signInWithGoogle() async {
    var response = await googleSignInUseCase();
    if (response.isSuccess()) {
      Get.offAllNamed(mainRoute);
    } else {
      Get.snackbar("구글 로그인에 실패하였습니다", "네트워크 상태를 확인 후 다시 시도해주세요");
    }
  }
}
