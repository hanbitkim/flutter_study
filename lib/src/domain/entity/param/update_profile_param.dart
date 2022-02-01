import 'package:artitecture/src/domain/entity/response/category.dart';

class UpdateProfileParam {
  String nickname;
  List<Category> categories;

  UpdateProfileParam(this.nickname, this.categories);
}