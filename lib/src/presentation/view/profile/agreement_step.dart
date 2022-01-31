import 'package:artitecture/src/presentation/controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class AgreementStep extends HookWidget {
  const AgreementStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        children: [
          Row(
            children: [
              Material(
                child: Checkbox(
                  value: EditProfileController.to.isAgreementChecked.value,
                  onChanged: (value) {
                    EditProfileController.to.setAgreementChecked(value ?? false);
                  },
                ),
              ),
            const Text(
              '약관에 동의합니다',
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        ElevatedButton(
            onPressed: EditProfileController.to.isAgreementChecked.value ? () => EditProfileController.to.next() : null,
            child: const Text('다음'))
      ]),
    );
  }
}