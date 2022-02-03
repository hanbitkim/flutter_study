import 'package:artitecture/src/domain/entity/response/category.dart';

class UploadArticleParam {
  String? categoryId;
  String? title;
  String? contents;
  List<String> images;

  UploadArticleParam(this.categoryId, this.title, this.contents, this.images);
}