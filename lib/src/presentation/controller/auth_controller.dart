import 'package:artitecture/src/core/resources/error_code.dart';
import 'package:artitecture/src/domain/usecase/get_user_usecase.dart';
import 'package:artitecture/src/domain/usecase/google_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_up_usecase.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final GetUserUseCase _getUserUseCase;

  AuthController(this._signInUseCase, this._signUpUseCase, this._googleSignInUseCase, this._getUserUseCase);

  final isLoading = RxBool(false);

  void signIn(String email, String password) async {
    isLoading.value = true;
    final response = await _signInUseCase(email, password);
    if (response.isSuccess()) {
      _getUser();
    } else {
      Get.snackbar("로그인에 실패하였습니다", "이메일과 비밀번호를 확인해주세요");
    }
    isLoading.value = false;
  }

  void signUp(String email, String password) async {
    isLoading.value = true;
    var response = await _signUpUseCase(email, password);
    if (response.isSuccess()) {
      Get.offAllNamed(editProfileRoute);
    } else {
      if (response.error?.code == weekPasswordError) {
        Get.snackbar("가입에 실패하였습니다", "비밀번호가 취약합니다");
      } else if (response.error?.code == emailAlreadyInUseError) {
        Get.snackbar("가입에 실패하였습니다", "이미 가입된 이메일입니다");
      } else {
        Get.snackbar("가입에 실패하였습니다", "이메일과 비밀번호를 확인해주세요");
      }
    }
    isLoading.value = false;
  }

  void signInWithGoogle() async {
    var response = await _googleSignInUseCase();
    if (response.isSuccess()) {
      _getUser();
    } else {
      Get.snackbar("구글 로그인에 실패하였습니다", "네트워크 상태를 확인 후 다시 시도해주세요");
    }
  }

  void _getUser() async {
    final userResponse = await _getUserUseCase();
    if (userResponse.isSuccess()) {
      if (userResponse.getData()?.isApproved == true) {
        Get.offAllNamed(mainRoute);
      } else {
        Get.offAllNamed(editProfileRoute);
      }
    } else {
      Get.snackbar("로그인에 실패하였습니다", "유저 정보가 없습니다");
    }
  }
}
