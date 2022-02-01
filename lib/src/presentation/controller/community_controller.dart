import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  static CommunityController get to => Get.find();

  final RxList<Article> articles = RxList();

  void fetch(String? categoryId, [int? lastArticleDate]) {

  }
}