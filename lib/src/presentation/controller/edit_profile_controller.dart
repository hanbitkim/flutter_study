import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileController extends GetxController {
  static EditProfileController get to => Get.find();

  final isAgreementChecked = false.obs;

  final PublishSubject<bool> _goToNext = PublishSubject();
  PublishSubject<bool> get goToNext => _goToNext;

  EditProfileController();

  void setAgreementChecked(bool isChecked) {
    isAgreementChecked.value = isChecked;
  }

  void next() {
    _goToNext.add(true);
  }
}