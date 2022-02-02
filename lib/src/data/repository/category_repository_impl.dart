import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/data/source/remote/firebase_api.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/domain/repository/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final FirebaseApi _firebaseApi;

  CategoryRepositoryImpl(this._firebaseApi);

  @override
  Future<ResultWrapper<List<Category>>> getCategories() {
    return _firebaseApi.getCategories();
  }

  @override
  Future<ResultWrapper<List<Article>>> getArticles(String? categoryId, int? lastArticleDate) {
    return _firebaseApi.getArticles(categoryId, lastArticleDate);
  }
}