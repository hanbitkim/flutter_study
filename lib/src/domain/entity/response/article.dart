import 'package:artitecture/src/domain/entity/response/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
class Article with _$Article {
  factory Article({
    required String? id,
    required String? title,
    required String? contents,
    required int commentCount,
    required int likeCount,
    required bool? isReported,
    required List<Image> images
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}