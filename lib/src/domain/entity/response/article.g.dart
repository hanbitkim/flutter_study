// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Article _$$_ArticleFromJson(Map<String, dynamic> json) => _$_Article(
      id: json['id'] as String?,
      title: json['title'] as String?,
      contents: json['contents'] as String?,
      commentCount: json['commentCount'] as int,
      likeCount: json['likeCount'] as int,
      isReported: json['isReported'] as bool?,
      images: (json['images'] as List<dynamic>)
          .map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ArticleToJson(_$_Article instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contents': instance.contents,
      'commentCount': instance.commentCount,
      'likeCount': instance.likeCount,
      'isReported': instance.isReported,
      'images': instance.images,
    };
