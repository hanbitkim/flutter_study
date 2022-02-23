import 'package:artitecture/src/core/utils/colors.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/auth_controller.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SignInPage extends HookWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.put(injector());
    final TextEditingController _emailController = useTextEditingController();
    final TextEditingController _passwordController = useTextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    useEffect(() {
      final subscription = _authController.isLoading.listen((value) {
        if (value) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }
      });
      return subscription.cancel;
    }, [_authController]);

    return Scaffold(
      body: SafeArea(
        child: Container(
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
                    ],
                  )),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                child: Container(
                  child: const Text('이메일로 로그인'),
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
                    _authController.signIn(_emailController.text, _passwordController.text);
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                child: Container(
                  child: const Text(
                    '구글 계정으로 로그인',
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
                  FocusManager.instance.primaryFocus?.unfocus();
                  _authController.signInWithGoogle();
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      '비밀번호를 잊으셨나요?',
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.toNamed(findPasswordRoute);
                    },
                    child: Container(
                      child: const Text(
                        '비밀번호 찾기',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      '계정이 없으신가요?',
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Get.toNamed(signUpRoute);
                    },
                    child: Container(
                      child: const Text(
                        '가입하기',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
