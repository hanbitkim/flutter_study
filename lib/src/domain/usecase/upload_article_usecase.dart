import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/param/upload_article_param.dart';
import 'package:artitecture/src/domain/repository/community_repository.dart';

class UploadArticleUseCase {
  final CommunityRepository _communityRepository;

  UploadArticleUseCase(this._communityRepository);

  Future<ResultWrapper> call(UploadArticleParam param) async {
    return _communityRepository.uploadArticle(param);
  }
}