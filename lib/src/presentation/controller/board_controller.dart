import 'package:artitecture/src/core/utils/constants.dart';
import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/domain/usecase/get_articles_usecase.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class BoardController extends GetxController {
  static BoardController get(String? tag) => Get.find(tag: tag);
  static const loadingBuffer = 500;

  final GetArticlesUseCase _getArticlesUseCase;

  BoardController(this._getArticlesUseCase);

  final articles = <Article>[].obs;
  final scrollController = ScrollController().obs;
  var _isLoading = false;
  var _hasMore = false;
  late Category _category;

  @override
  void onInit() {
    scrollController.value.addListener(() {
      if (_isLoading || !_hasMore) {
        return;
      }
      if (scrollController.value.position.maxScrollExtent - scrollController.value.position.pixels <= loadingBuffer) {
        getArticles(_category.id, articles.last.createdDate);
      }
    });
    super.onInit();
  }
  
  void setCategory(Category category) {
    _category = category;
    getArticles(category.id);
  }

  void getArticles(String? categoryId, [int? lastArticleDate]) async {
    _isLoading = true;
    final response = await _getArticlesUseCase(categoryId, lastArticleDate);
    Logger().d('getArticles] categoryId = $categoryId, lastArticleDate = $lastArticleDate, response = $response');
    if (response.isSuccess()) {
      articles.addAll(response.data?.toList() ?? List.empty());
      _hasMore = response.data?.length == kPageSize;
    }
    _isLoading = false;
  }
}