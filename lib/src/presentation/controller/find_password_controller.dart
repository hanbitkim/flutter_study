import 'package:artitecture/src/core/resources/error_code.dart';
import 'package:artitecture/src/domain/usecase/reset_password_usecase.dart';
import 'package:get/get.dart';

class FindPasswordController extends GetxController {
  static FindPasswordController get to => Get.find();

  final ResetPasswordUseCase resetPasswordUseCase;

  FindPasswordController(this.resetPasswordUseCase);

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
}
