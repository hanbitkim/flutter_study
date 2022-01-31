import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  factory User({
    required String? name,
    required String? email,
    required String? profileUrl,
    required bool? isApproved
  }) = _User;
}
