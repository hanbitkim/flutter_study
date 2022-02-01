import 'package:artitecture/src/core/utils/colors.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/main_controller.dart';
import 'package:artitecture/src/presentation/view/community/community.dart';
import 'package:artitecture/src/presentation/view/main/tab_three.dart';
import 'package:artitecture/src/presentation/view/main/tab_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MainPage extends HookWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController _mainController = Get.put(injector());
    final List<Widget> _children = [const CommunityTab(), const TabTwo(), const TabThree()];
    final _prevPressedTime = useState(DateTime.now());

    return WillPopScope(
      onWillPop: () async {
        final timeDiff = DateTime.now().difference(_prevPressedTime.value);
        final isFirstClick = timeDiff >= const Duration(seconds: 2);
        _prevPressedTime.value = DateTime.now();
        if (isFirstClick) {
          await Fluttertoast.showToast(
              msg: "종료하시려면 한번 더 눌러주세요",
              toastLength: Toast.LENGTH_SHORT
          );
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Obx(() => Scaffold(
          body: Center(
            child: _children[_mainController.tabIndex.value]
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera),
                label: 'Camera',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: 'Chats',
              ),
            ],
            onTap: (int index) => _mainController.selectTab(index),
            currentIndex: _mainController.tabIndex.value,
            backgroundColor: primaryColor,
          ),
        )),
      ),
    );
  }
}