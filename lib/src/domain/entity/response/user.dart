import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    required String? id,
    required String? nickname,
    required String? email,
    required String? profileUrl,
    required bool? isApproved,
    required List<Category> categories
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}