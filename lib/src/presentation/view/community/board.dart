import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/board_controller.dart';
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

  @override
  void initState() {
    final BoardController _boardController = Get.put(injector(), tag: widget._category.name);
    _boardController.setCategory(widget._category);
    super.initState();
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
              delegate: SliverChildBuilderDelegate((context, index) => ListTile(title: Text(BoardController.get(widget._category.name).articles[index].title)),
                  childCount: BoardController.get(widget._category.name).articles.length
              )
          )
        ]
      ),
    ));
  }

  @override
  bool get wantKeepAlive => true;
}