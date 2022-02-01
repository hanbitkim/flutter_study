// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['id'] as String?,
      nickname: json['nickname'] as String?,
      email: json['email'] as String?,
      profileUrl: json['profileUrl'] as String?,
      isApproved: json['isApproved'] as bool?,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'email': instance.email,
      'profileUrl': instance.profileUrl,
      'isApproved': instance.isApproved,
    };
