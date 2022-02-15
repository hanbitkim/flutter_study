import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/response/comment.dart';
import 'package:artitecture/src/domain/repository/community_repository.dart';

class GetCommentsUseCase {
  final CommunityRepository _categoryRepository;

  GetCommentsUseCase(this._categoryRepository);

  Future<ResultWrapper<List<Comment>>> call(String? articleId, int? lastCommentDate) async {
    return _categoryRepository.getComments(articleId, lastCommentDate);
  }
}
