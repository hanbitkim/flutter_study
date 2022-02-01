import 'package:artitecture/src/core/global.dart';
import 'package:artitecture/src/core/utils/colors.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/community_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class CommunityTab extends HookWidget {
  const CommunityTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CommunityController _communityController = Get.put(injector());
    final TabController _tabController = useTabController(initialLength: user.value?.categories.length ?? 0);
    final PageController _pageController = usePageController();

    return Obx(() => Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: user.value?.categories.map((category) => getTab(category)).toList() ?? List.empty(),
            onTap: (index) => _pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _communityController.userData.value?.categories.map((category) => Text(category.name ?? "")).toList() ?? List.empty(),
              onPageChanged: (page) => _tabController.animateTo(page),
            ),
          )
        ],
      ),
    );
  }

  Tab getTab(Category category) {
    return Tab(child: Text(category.name ?? '', style: const TextStyle(color: primaryColor),));
  }
}