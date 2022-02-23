import 'package:artitecture/src/core/utils/colors.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/auth_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class SignUpPage extends HookWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.put(injector());
    final TextEditingController _emailController = useTextEditingController();
    final TextEditingController _passwordController = useTextEditingController();
    final TextEditingController _passwordConfirmController = useTextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("회원가입"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: "이메일을 입력해주세요"),
                      validator: (String? value) {
                        if (!EmailValidator.validate(value ?? "")) {
                          return "이메일을 입력해주세요";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "비밀번호를 입력해주세요"),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "비밀번호를 입력해주세요";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordConfirmController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: "비밀번호를 다시 입력해주세요"),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "비밀번호를 입력해주세요";
                        }
                        if (value != _passwordController.text) {
                          return "같은 비밀번호를 입력해주세요";
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                child: Container(
                  child: const Text('가입하기'),
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
                    _authController.signUp(_emailController.text, _passwordController.text);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
