import 'package:artitecture/src/core/resources/error_code.dart';
import 'package:artitecture/src/domain/entity/param/update_profile_param.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/domain/usecase/get_category_usecase.dart';
import 'package:artitecture/src/domain/usecase/update_profile_usecase.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find();

  final GetCategoryUseCase _getCategoryUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  final isAgreementChecked = false.obs;
  final nickname = "".obs;
  final RxList<Category> categories = RxList();
  final RxList<Category> unSelectedCategories = RxList();
  final RxList<Category> selectedCategories = RxList();
  final isLoading = RxBool(false);

  final PublishSubject<bool> _goToNext = PublishSubject();
  PublishSubject<bool> get goToNext => _goToNext;

  EditProfileController(this._updateProfileUseCase, this._getCategoryUseCase);

  @override
  void onInit() async {
    super.onInit();
    _getCategoryUseCase().then((value) {
      if (value.isSuccess()) {
        categories.addAll(value.getData());
        unSelectedCategories.value = value.getData();
      }
    });
  }

  void setAgreementChecked(bool isChecked) {
    isAgreementChecked.value = isChecked;
  }

  void setNickname(String name) {
    nickname.value = name;
  }

  void selectCategory(String id) {
    if (selectedCategories.where((element) => element.id == id).isEmpty) {
      if (selectedCategories.length >= 3) {
        Get.snackbar("카테고리가 가득찼습니다", "최대 3개까지 선택 가능합니다");
        return;
      }
      selectedCategories.add(categories.firstWhere((element) => element.id == id));
    } else {
      selectedCategories.removeWhere((element) => element.id == id);
    }
    unSelectedCategories.value = categories.where((category) => !selectedCategories.contains(category)).toList();
  }

  void next() {
    _goToNext.add(true);
  }

  void updateProfile() async {
    if (selectedCategories.isEmpty) {
      Get.snackbar("카테고리가 비어있습니다", "최소 1개에서 최대 3개까지 선택 가능합니다");
      return;
    }
    isLoading.value = true;
    final response = await _updateProfileUseCase(UpdateProfileParam(nickname.value, selectedCategories));
    if (response.isSuccess()) {
      Get.offAllNamed(mainRoute);
    } else {
      if (response.error?.code == nicknameAlreadyInUseError) {
        Get.snackbar("사용중인 닉네임입니다", "다른 닉네임을 사용해주세요");
      } else {
        Get.snackbar("프로필 업데이트에 실패하였습니다", "네트워크 상태를 확인 후 다시 시도해주세요");
      }
    }
    isLoading.value = false;
  }
}