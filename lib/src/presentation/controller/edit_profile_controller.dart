import 'package:artitecture/src/core/resources/error_code.dart';
import 'package:artitecture/src/domain/entity/param/update_profile_param.dart';
import 'package:artitecture/src/domain/usecase/update_profile_usecase.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find();

  final UpdateProfileUseCase _updateProfileUseCase;

  final isAgreementChecked = false.obs;
  final nickname = "".obs;

  final PublishSubject<bool> _goToNext = PublishSubject();
  PublishSubject<bool> get goToNext => _goToNext;

  EditProfileController(this._updateProfileUseCase);

  void setAgreementChecked(bool isChecked) {
    isAgreementChecked.value = isChecked;
  }

  void setNickname(String name) {
    nickname.value = name;
  }

  void next() {
    _goToNext.add(true);
  }

  void updateProfile() async {
    final response = await _updateProfileUseCase(UpdateProfileParam(nickname.value));
    if (response.isSuccess()) {
      Get.offAllNamed(mainRoute);
    } else {
      if (response.error?.code == nicknameAlreadyInUseError) {
        Get.snackbar("사용중인 닉네임입니다", "다른 닉네임을 사용해주세요");
      } else {
        Get.snackbar("프로필 업데이트에 실패하였습니다", "네트워크 상태를 확인 후 다시 시도해주세요");
      }
    }
  }
}