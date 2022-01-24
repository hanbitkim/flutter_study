import 'package:artitecture/src/domain/usecase/sign_out_usecase.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:get/get.dart';

class MyPageController extends GetxController {
  static MyPageController get to => Get.find();

  final SignOutUseCase _signOutUseCase;

  MyPageController(this._signOutUseCase);

  void signOut() async {
    await _signOutUseCase();
    Get.offNamed(loginRoute);
  }
}
