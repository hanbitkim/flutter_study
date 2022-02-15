import 'package:artitecture/src/domain/entity/response/author.dart';
import 'package:artitecture/src/domain/entity/response/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  factory Comment({
    required String? id,
    required String? contents,
    required List<Image> images,
    required int likeCount,
    required bool isReported,
    required DateTime createdDate,
    required Author author,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
}
