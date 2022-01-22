import 'package:artitecture/src/presentation/deep_link_parser.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final deepLinkMethod = const MethodChannel('poc.deeplink.flutter.dev/channel');
  final deepLinkEvent = const EventChannel('poc.deeplink.flutter.dev/events');
  final tabIndex = RxInt(0);

  @override
  void onInit() {
    getDeepLink().then((value) {
      DeepLinkParser.parse(value);
    });
    deepLinkEvent.receiveBroadcastStream().listen((event) {
      DeepLinkParser.parse(event);
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
