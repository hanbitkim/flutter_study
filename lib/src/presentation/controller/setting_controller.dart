import 'package:artitecture/src/domain/usecase/secession_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_out_usecase.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  static SettingController get to => Get.find();

  final SignOutUseCase _signOutUseCase;
  final SecessionUseCase _secessionUseCase;

  SettingController(this._signOutUseCase, this._secessionUseCase);

  void signOut() async {
    var response = await _signOutUseCase();
    if (response.isSuccess()) {
      Get.offAllNamed(signInRoute);
    } else {
      Get.snackbar("에러가 발생했습니다", "네트워크 상태를 확인 후 다시 시도해주세요");
    }
  }

  void secession() async {
    var response = await _secessionUseCase();
    if (response.isSuccess()) {
      Get.offAllNamed(signInRoute);
    } else {
      Get.snackbar("에러가 발생했습니다", "네트워크 상태를 확인 후 다시 시도해주세요");
    }
  }
}
