import 'package:artitecture/src/core/utils/constants.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/domain/entity/response/comment.dart';
import 'package:artitecture/src/domain/usecase/get_article_usecase.dart';
import 'package:artitecture/src/domain/usecase/get_comments_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ArticleDetailController extends GetxController {
  static ArticleDetailController get to => Get.find();
  static const loadingBuffer = 500;

  final GetArticleUseCase _getArticleUseCase;
  final GetCommentsUseCase _getCommentsUseCase;

  ArticleDetailController(this._getArticleUseCase, this._getCommentsUseCase);

  final Rxn<Article> article = Rxn();
  final comments = <Comment>[].obs;
  final scrollController = ScrollController().obs;
  final isLoading = false.obs;
  var _hasMore = false;

  @override
  void onInit() {
    scrollController.value.addListener(() {
      if (isLoading.isTrue || !_hasMore) {
        return;
      }
      if (scrollController.value.position.maxScrollExtent - scrollController.value.position.pixels <= loadingBuffer) {
        getComments(comments.last.createdDate.millisecond);
      }
    });
    super.onInit();
  }

  void setArticle(Article _article) {
    article.value = _article;
    getComments();
  }

  void getArticle() async {
    final response = await _getArticleUseCase(article.value?.id);
    Logger().d('getArticle] _article.id = ${article.value?.id}, response = $response');
    if (response.isSuccess()) {
      article.value = response.data;
    }
  }

  void getComments([int? lastCommentDate]) async {
    isLoading.value = true;
    if (lastCommentDate == null) {
      comments.clear();
    }
    final response = await _getCommentsUseCase(article.value?.id, lastCommentDate);
    Logger().d('getComments] articleId = ${article.value?.id}, lastCommentDate = $lastCommentDate, response = $response');
    if (response.isSuccess()) {
      comments.addAll(response.data?.toList() ?? List.empty());
      _hasMore = response.data?.length == kPageSize;
    }
    isLoading.value = false;
  }
}
