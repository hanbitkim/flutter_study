import 'dart:math';

import 'package:artitecture/src/domain/entity/response/article.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/article_detail_controller.dart';
import 'package:artitecture/src/presentation/view/community/article_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ArticleDetailPageState();
  }
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    final ArticleDetailController _articleDetailController = Get.put(injector());
    final _params = Get.arguments as ArticleDetailParams;
    _articleDetailController.setArticle(_params.article);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 상세'),
      ),
      body: Obx(
        () => RefreshIndicator(
          key: _refreshKey,
          onRefresh: () async {
            _refreshKey.currentState?.show(atTop: false);
            ArticleDetailController.to.getComments();
          },
          child: Column(
            children: [
              if (ArticleDetailController.to.article.value != null) ArticleItemView(ArticleDetailController.to.article.value!),
              ArticleDetailController.to.isLoading.isFalse && ArticleDetailController.to.comments.isEmpty
                  ? const Center(
                      child: Text('댓글이 없습니다'),
                    )
                  : Expanded(
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        controller: ArticleDetailController.to.scrollController.value,
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index.isEven) {
                                  final int itemIndex = index ~/ 2;
                                  // return ArticleItemView(_boardController.articles[itemIndex]);
                                }
                                return Container(height: 10, color: Colors.grey.shade200);
                              },
                              childCount: max(0, ArticleDetailController.to.comments.length * 2 - 1),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArticleDetailParams {
  Article article;

  ArticleDetailParams({required this.article});
}
