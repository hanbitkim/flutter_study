import 'dart:io';

class PlatformUtil {
  static String getPlatformName() {
    if (Platform.isAndroid) {
      return "android";
    } else if (Platform.isIOS) {
      return "ios";
    }
    return "";
  }
}