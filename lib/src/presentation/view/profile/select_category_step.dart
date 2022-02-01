import 'package:artitecture/src/core/utils/colors.dart';
import 'package:artitecture/src/presentation/controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class SelectCategoryStep extends HookWidget {
  const SelectCategoryStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        children: [
          const Text('선택된 카테고리'),
          MultiSelectChipDisplay(
            items: EditProfileController.to.selectedCategories.map((e) => MultiSelectItem(e.id, e.name ?? "")).toList(),
            onTap: (value) => EditProfileController.to.selectCategory(value as String),
          ),
          const Text('전체 카테고리'),
          MultiSelectChipDisplay(
            items: EditProfileController.to.unSelectedCategories.map((e) => MultiSelectItem(e.id, e.name ?? "")).toList(),
            onTap: (value) => EditProfileController.to.selectCategory(value as String),
          ),
          ElevatedButton(
            onPressed: () => EditProfileController.to.updateProfile(),
            child: EditProfileController.to.isLoading.value
                ? const CircularProgressIndicator(color: primaryColor)
                : const Text('완료',)
          )
        ]),
    );
  }
}