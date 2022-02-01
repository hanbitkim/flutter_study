import 'package:artitecture/src/presentation/controller/edit_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NickNameStep extends HookWidget {
  const NickNameStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _nicknameController = useTextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nicknameController,
                    decoration: const InputDecoration(labelText: "닉네임을 입력해주세요"),
                    validator: (String? value) {
                      if (value == null || value.trim().length < 3) {
                        return '3자 이상 입력해주세요';
                      }
                      return null;
                    },
                    onChanged: (value) => EditProfileController.to.setNickname(value),
                  ),
                ],
              )),
          const SizedBox(
            height: 24,
          ),
          InkWell(
            child: Container(
              child: const Text(
                '완료',
              ),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
            ),
            onTap: () {
              if (_formKey.currentState?.validate() == true) {
                FocusManager.instance.primaryFocus?.unfocus();
                EditProfileController.to.next();
              }
            },
          ),
        ],
      ),
    );
  }
}