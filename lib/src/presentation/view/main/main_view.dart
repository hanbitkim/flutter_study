import 'package:artitecture/src/core/utils/colors.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/main_controller.dart';
import 'package:artitecture/src/presentation/view/main/tab_one.dart';
import 'package:artitecture/src/presentation/view/main/tab_three.dart';
import 'package:artitecture/src/presentation/view/main/tab_two.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MainController _mainController = Get.put(injector());
    final List<Widget> _children = [const TabOne(), const TabTwo(), const TabThree()];

    return Obx(() => Scaffold(
      body: Center(
        child: _children[_mainController.tabIndex.value]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
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
    ));
  }
}