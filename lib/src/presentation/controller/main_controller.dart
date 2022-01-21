import 'package:artitecture/src/presentation/deep_link_parser.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class MainController extends GetxController {
  final platform = const MethodChannel('poc.deeplink.flutter.dev/channel');

  @override
  void onInit() {
    getDeepLink().then((value) {
      Logger().d("deepLink = $value");
      DeepLinkParser.parse(value);
    });
    super.onInit();
  }

  Future<String?> getDeepLink() async {
    try {
      return platform.invokeMethod<String>('getDeepLink');
    } on PlatformException catch (e) {
      return "failed to get initialLink = ${e.message}";
    }
  }
}
