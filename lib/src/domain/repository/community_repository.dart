import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/param/upload_article_param.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';

abstract class CommunityRepository {
  Future<ResultWrapper<List<Category>>> getCategories();
  Future<ResultWrapper<List<Article>>> getArticles(String? categoryId, int? lastArticleDate);
  Future<ResultWrapper> uploadArticle(UploadArticleParam param);
}