import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/domain/repository/category_repository.dart';

class GetArticlesUseCase {
  final CategoryRepository _categoryRepository;

  GetArticlesUseCase(this._categoryRepository);

  Future<ResultWrapper<List<Article>>> call(String? categoryId, int? lastArticleDate) async {
    return _categoryRepository.getArticles(categoryId, lastArticleDate);
  }
}