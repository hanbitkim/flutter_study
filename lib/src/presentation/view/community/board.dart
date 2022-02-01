import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/community_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class BoardView extends HookWidget {
  final Category _category;

  const BoardView(this._category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CommunityController _communityController = Get.put(injector(), tag: _category.name);
    final ScrollController _scrollController = useScrollController();
    final buffer = MediaQuery.of(context).size.height * 0.25;

    useEffect(() {
      void _callback() {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;
        if (maxScroll - currentScroll < buffer) {

        }
      }
      _scrollController.addListener(_callback);
      return () => _scrollController.removeListener(_callback);
    }, [_scrollController]);

    useEffect(() {
      _communityController.fetch(_category.id);
    }, []);

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverList(
            delegate:
            SliverChildBuilderDelegate(
                (context, index) => ListTile(title: Text('${_category.name} Item #$index')),
                childCount: 10
            )
        )],
    );
  }
}
