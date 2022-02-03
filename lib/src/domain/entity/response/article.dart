import 'package:artitecture/src/domain/entity/response/author.dart';
import 'package:artitecture/src/domain/entity/response/comment.dart';
import 'package:artitecture/src/domain/entity/response/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
class Article with _$Article {
  factory Article({
    required String id,
    required String title,
    required String contents,
    required List<Image> images,
    required int commentCount,
    required int likeCount,
    required bool isReported,
    required int createdDate,
    required Author author,
    required List<Comment> comments
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);
}