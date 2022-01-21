import 'package:artitecture/src/presentation/route.dart';
import 'package:get/get.dart';

class DeepLinkParser {
  static void parse(String? deepLinkUrl) {
    if (deepLinkUrl != null) {
      var uri = Uri.parse(deepLinkUrl);
      // if (uri.host == "findpassword") {
      //   Get.toNamed(findPasswordRoute);
      // }
    }
  }
}