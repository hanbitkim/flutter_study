import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/edit_profile_controller.dart';
import 'package:artitecture/src/presentation/view/profile/agreement_step.dart';
import 'package:artitecture/src/presentation/view/profile/nickname_step.dart';
import 'package:artitecture/src/presentation/view/profile/select_category_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class EditProfilePage extends HookWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EditProfileController _editProfileController = Get.put(injector());
    final PageController _pageController = usePageController();
    final currentStep = useState(1);
    final stepProgress = useState(currentStep.value.toDouble() / steps.length);

    useEffect(() {
      final subscription = _editProfileController.goToNext.listen((value) {
        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      });
      return subscription.cancel;
    }, [_editProfileController]);

    useEffect(() {
      void _callback() {
        stepProgress.value = currentStep.value.toDouble() / steps.length;
      }
      currentStep.addListener(_callback);
      return () => currentStep.removeListener(_callback);
    }, [currentStep]);

    useEffect(() {
      void _callback() {
        final page = (_pageController.page?.toInt() ?? 0) + 1;
        if (currentStep.value != page) {
          currentStep.value = page;
        }
      }
      _pageController.addListener(_callback);
      return () => _pageController.removeListener(_callback);
    }, [_pageController]);

    return WillPopScope(
      onWillPop: () async {
        final page = _pageController.page?.toInt() ?? 0;
        if (page > 0) {
          _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        } else {
          _showExitConfirmDialog(context);
        }
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              LinearProgressIndicator(value: stepProgress.value),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: steps,
                ),
              )
            ],
          ),
        )
      ),
    );
  }

  void _showExitConfirmDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('앱을 종료하시겠습니까?'),
          content: const Text('프로필 설정을 취소하시면 앱이 종료됩니다'),
          actions: <Widget>[
            TextButton(
              onPressed: () => SystemNavigator.pop(),
              child: const Text('종료'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('계속하기'),
            ),
          ],
        ));
  }
}

final steps = [
  const AgreementStep(),
  const NickNameStep(),
  const SelectCategoryStep()
];