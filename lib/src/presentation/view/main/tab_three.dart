import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/mypage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabThree extends StatelessWidget {
  const TabThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyPageController _myPageController = Get.put(injector());

    return ElevatedButton(onPressed: () async {
      _myPageController.signOut();
    }, child: const Text('logout'));
  }
}