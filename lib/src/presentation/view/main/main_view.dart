import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/main_controller.dart';
import 'package:artitecture/src/presentation/view/community/community.dart';
import 'package:artitecture/src/presentation/view/main/tab_two.dart';
import 'package:artitecture/src/presentation/view/mypage/mypage_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  late final List<Widget> _children;
  late DateTime _lastPressedTime;

  @override
  void initState() {
    final MainController _mainController = Get.put(injector());
    _children = [const CommunityTab(), const TabTwo(), const MyPageView()];
    _lastPressedTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timeDiff = DateTime.now().difference(_lastPressedTime);
        final isFirstClick = timeDiff >= const Duration(seconds: 2);
        _lastPressedTime = DateTime.now();
        if (isFirstClick) {
          await Fluttertoast.showToast(msg: "종료하시려면 한번 더 눌러주세요", toastLength: Toast.LENGTH_SHORT);
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
        child: Obx(() => Scaffold(
              body: IndexedStack(
                index: MainController.to.tabIndex.value,
                children: _children,
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.chat),
                    label: '커뮤니티',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.camera),
                    label: 'Camera',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.more_horiz),
                    label: '더보기',
                  ),
                ],
                onTap: (int index) => MainController.to.selectTab(index),
                currentIndex: MainController.to.tabIndex.value,
              ),
            )),
      ),
    );
  }
}
