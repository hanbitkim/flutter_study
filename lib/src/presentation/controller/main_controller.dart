import 'package:artitecture/src/presentation/deep_link_manager.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController get to => Get.find();

  final deepLinkMethod = const MethodChannel('poc.deeplink.flutter.dev/channel');
  final deepLinkEvent = const EventChannel('poc.deeplink.flutter.dev/events');
  final tabIndex = RxInt(0);

  @override
  void onInit() {
    getDeepLink().then((value) {
      DeepLinkManager.handleUrl(value);
    });
    deepLinkEvent.receiveBroadcastStream().listen((event) {
      DeepLinkManager.handleUrl(event);
    });
    super.onInit();
  }

  Future<String?> getDeepLink() async {
    try {
      return deepLinkMethod.invokeMethod<String>('getDeepLink');
    } on PlatformException catch (e) {
      return "failed to get initialLink = ${e.message}";
    }
  }

  void selectTab(int index) {
    tabIndex.value = index;
  }
}
