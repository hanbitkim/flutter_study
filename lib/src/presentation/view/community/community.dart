import 'package:artitecture/src/core/global.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:artitecture/src/presentation/view/community/board.dart';
import 'package:artitecture/src/presentation/view/community/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class CommunityTab extends HookWidget {
  const CommunityTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TabController _tabController = useTabController(initialLength: user.value?.categories.length ?? 0);
    final PageController _pageController = usePageController();

    return Obx(() => Stack(
      children: [
        Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: user.value?.categories.map((category) => TabItemView(category)).toList() ?? List.empty(),
              onTap: (index) => _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                children: user.value?.categories.map((category) => BoardView(category)).toList() ?? List.empty(),
                onPageChanged: (page) => _tabController.animateTo(page),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            margin: const EdgeInsets.only(bottom: 20.0, right: 20.0),
            child: FloatingActionButton(
              child: const Icon(Icons.add, color: Colors.white),
              onPressed: () => Get.toNamed(articleWriteRoute),
            ),
          ),
        )
      ],
    ));
  }
}