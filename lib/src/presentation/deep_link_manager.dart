import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:logger/logger.dart';

class DeepLinkManager {
  static void handleUrl(String? deepLinkUrl) {
    if (deepLinkUrl != null) {
      handleUri(Uri.parse(deepLinkUrl));
    }
  }

  static void handleUri(Uri uri) {
    Logger().d("deepLink = ${uri.toString()}");
    // if (uri.host == "findpassword") {
    //   Get.toNamed(findPasswordRoute);
    // }
  }

  static void sendDynamicLinkUri(Uri linkUri) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://artitecture.page.link',
      link: linkUri,
      androidParameters: const AndroidParameters(
        packageName: 'com.example.artitecture',
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.monstarlab.monstarlabDynamicLinksDemo',
        appStoreId: '962194608',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: "title",
        description: "description",
        imageUrl: Uri.parse("https://picsum.photos/200"),
      ),
    );
    final ShortDynamicLink shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri shortUrl = shortDynamicLink.shortUrl;
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: shortUrl.toString(),
        chooserTitle: 'Example Chooser Title'
    );
  }
}