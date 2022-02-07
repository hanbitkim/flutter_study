import 'package:artitecture/src/core/global.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/mypage_controller.dart';
import 'package:artitecture/src/presentation/util/dialog_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyPageController _myPageController = Get.put(injector());

    return Obx(() => Column(children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  user.value?.profileUrl == null
                      ? const CircleAvatar(radius: 50, child: Icon(Icons.account_circle, size: 100), backgroundColor: Colors.transparent)
                      : CircleAvatar(radius: 50.0, backgroundImage: CachedNetworkImageProvider(user.value?.profileUrl ?? '')
                  ),
                  ElevatedButton(
                    child: const Icon(Icons.camera),
                    onPressed: () => DialogHelper.showImagePickerDialog(context, (path) {
                      _myPageController.updateProfileImage(path);
                    }),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(30, 30),
                      shape: const CircleBorder(),
                    ),
                  )
                ],
              ),
            ],
          )
        ]
    ));
  }
}
