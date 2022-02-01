import 'package:get/get.dart';

class CommunityController extends GetxController {
  static CommunityController get to => Get.find();

  final RxList articles = RxList();

  void fetch(String? categoryId, [int? lastArticleDate]) {

  }
}