import 'dart:async';
import 'dart:math';

import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/board_controller.dart';
import 'package:artitecture/src/presentation/event/article_uploaded_event.dart';
import 'package:artitecture/src/presentation/event/eventbus.dart';
import 'package:artitecture/src/presentation/view/community/article_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardView extends StatefulWidget {
  final Category _category;

  const BoardView(this._category, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BoardViewState();
  }
}

class _BoardViewState extends State<BoardView> with AutomaticKeepAliveClientMixin<BoardView> {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  late StreamSubscription eventBusSubscription;

  @override
  void initState() {
    final BoardController _boardController = Get.put(injector(), tag: widget._category.name);
    _boardController.setCategory(widget._category);
    eventBusSubscription = eventBus.on<ArticleUploadedEvent>().listen((event) {
      if (event.categoryId == widget._category.id) {
        BoardController.get(widget._category.name).getArticles(widget._category.id);
      }
    });
    super.initState();
  }

  @override
  void deactivate() {
    eventBusSubscription.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Obx(() => RefreshIndicator(
      key: _refreshKey,
      onRefresh: () async {
        _refreshKey.currentState?.show(atTop: false);
        BoardController.get(widget._category.name).getArticles(widget._category.id);
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: BoardController.get(widget._category.name).scrollController.value,
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index.isEven) {
                  final int itemIndex = index ~/ 2;
                  return ArticleItemView(BoardController.get(widget._category.name).articles[itemIndex]);
                }
                return Container(height: 10, color: Colors.grey.shade200);
                },
                childCount: max(0, BoardController.get(widget._category.name).articles.length * 2 - 1),
              )
          )
        ]
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}