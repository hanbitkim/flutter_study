import 'package:get/get.dart';

class ArticleWriteController extends GetxController {
  static ArticleWriteController get to => Get.find();

  final Rxn<String?> categoryId = Rxn();
  final Rxn<String?> title = Rxn();
  final Rxn<String?> contents = Rxn();
}