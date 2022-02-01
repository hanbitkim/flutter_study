// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      id: json['id'] as String?,
      contents: json['contents'] as String?,
      images: (json['images'] as List<dynamic>)
          .map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      likeCount: json['likeCount'] as int,
      isReported: json['isReported'] as bool,
      createdDate: json['createdDate'] as int,
      updatedDate: json['updatedDate'] as int,
      author: Author.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contents': instance.contents,
      'images': instance.images,
      'likeCount': instance.likeCount,
      'isReported': instance.isReported,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'author': instance.author,
    };
