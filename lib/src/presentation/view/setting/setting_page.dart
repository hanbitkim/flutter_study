import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/mypage_controller.dart';
import 'package:artitecture/src/presentation/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingController _settingController = Get.put(injector());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () async {
          _settingController.signOut();
        }, child: const Text('로그아웃')),
        ElevatedButton(onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('탈퇴하시겠습니까?'),
                content: const Text('탈퇴 후 되돌릴 수 없습니다'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _settingController.secession();
                    },
                    child: const Text('확인'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('취소'),
                  ),
                ],
              ));
        }, child: const Text('탈퇴')),
      ],
    );
  }
}