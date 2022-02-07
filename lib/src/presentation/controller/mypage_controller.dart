import 'package:artitecture/src/domain/usecase/update_profile_image_usecase.dart';
import 'package:get/get.dart';

class MyPageController extends GetxController {
  static MyPageController get to => Get.find();

  final UpdateProfileImageUseCase _updateProfileImageUseCase;

  MyPageController(this._updateProfileImageUseCase);

  void updateProfileImage(String? path) async {
    if (path != null) {
      await _updateProfileImageUseCase(path);
    }
  }
}
