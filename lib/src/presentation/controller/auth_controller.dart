import 'package:artitecture/src/domain/usecase/google_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_up_usecase.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final GoogleSignInUseCase googleSignInUseCase;

  AuthController(this.signInUseCase, this.signUpUseCase, this.googleSignInUseCase);

  final isLoading = RxBool(false);

  void signIn(String email, String password) async {
    isLoading.value = true;
    var response = await signInUseCase(email, password);
    if (response.isSuccess()) {
      Get.offNamed(mainRoute);
    } else {
      Get.snackbar("로그인에 실패하였습니다", "이메일과 비밀번호를 확인해주세요");
    }
    isLoading.value = false;
  }

  void signUp(String email, String password) async {
    isLoading.value = true;
    var response = await signUpUseCase(email, password);
    if (response.isSuccess()) {
      Get.offAllNamed(editProfileRoute);
    } else {
      Get.snackbar("가입에 실패하였습니다", "이메일과 비밀번호를 확인해주세요");
    }
    isLoading.value = false;
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
