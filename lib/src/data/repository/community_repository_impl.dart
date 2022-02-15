import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/data/source/remote/firebase_api.dart';
import 'package:artitecture/src/domain/entity/param/upload_article_param.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/domain/entity/response/comment.dart';
import 'package:artitecture/src/domain/repository/community_repository.dart';

class CommunityRepositoryImpl extends CommunityRepository {
  final FirebaseApi _firebaseApi;

  CommunityRepositoryImpl(this._firebaseApi);

  @override
  Future<ResultWrapper<List<Category>>> getCategories() {
    return _firebaseApi.getCategories();
  }

  @override
  Future<ResultWrapper<List<Article>>> getArticles(String? categoryId, int? lastArticleDate) {
    return _firebaseApi.getArticles(categoryId, lastArticleDate);
  }

  @override
  Future<ResultWrapper> uploadArticle(UploadArticleParam param) {
    return _firebaseApi.uploadArticle(param);
  }

  @override
  Future<ResultWrapper<Article>> getArticle(String? articleId) {
    return _firebaseApi.getArticle(articleId);
  }

  @override
  Future<ResultWrapper<List<Comment>>> getComments(String? articleId, int? lastCommentDate) {
    return _firebaseApi.getComments(articleId, lastCommentDate);
  }
}
