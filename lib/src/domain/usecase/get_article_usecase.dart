import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/domain/repository/community_repository.dart';

class GetArticleUseCase {
  final CommunityRepository _categoryRepository;

  GetArticleUseCase(this._categoryRepository);

  Future<ResultWrapper<Article>> call(String? articleId) async {
    return _categoryRepository.getArticle(articleId);
  }
}
