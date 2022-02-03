import 'package:get/get.dart';

class ArticleWriteController extends GetxController {
  static ArticleWriteController get to => Get.find();

  final Rxn<String?> categoryId = Rxn();
  final Rxn<String?> title = Rxn();
  final Rxn<String?> contents = Rxn();
  final images = <String>[].obs;

  void setCategoryId(String? categoryId) {
    this.categoryId.value = categoryId;
  }

  void setTitle(String? title) {
    this.title.value = title;
  }

  void setContents(String? contents) {
    this.contents.value = contents;
  }

  void addImage(String? path) {
    if (path != null && path.isNotEmpty) {
      images.add(path);
    }
  }
}