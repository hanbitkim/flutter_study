import 'package:artitecture/src/core/global.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/mypage_controller.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:artitecture/src/presentation/util/dialog_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyPageController _myPageController = Get.put(injector());

    return Obx(() => Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () => Get.toNamed(settingRoute),
                  icon: const Icon(Icons.settings, size: 30)
              )
          ),
          Row(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    placeholder: (context, url) => const Icon(Icons.account_circle, size: 100),
                    errorWidget: (context, url, error) => const Icon(Icons.account_circle, size: 100),
                    fit: BoxFit.contain,
                    imageUrl: user.value?.profileUrl ?? '',
                    imageBuilder: (context, imageProvider) {
                      return CircleAvatar(
                        radius: 50,
                        backgroundImage: imageProvider,
                      );
                    },
                  ),
                  Positioned(
                      top: 55,
                      left: 50,
                      child: getCameraButton(context)
                  )
                ],
              ),
              const SizedBox(width: 20),
              Text(user.value?.nickname ?? '', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
            ],
          )
        ]
    ));
  }

  Widget getCameraButton(BuildContext context) {
    return ElevatedButton(
      child: const Icon(Icons.camera_alt),
      onPressed: () => DialogHelper.showImagePickerDialog(context, (path) {
        MyPageController.to.updateProfileImage(path);
      }),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(30, 30),
        shape: const CircleBorder(),
      ),
    );
  }
}
