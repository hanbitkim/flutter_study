import 'package:artitecture/src/core/utils/colors.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/auth_controller.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

class SignInPage extends HookWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = Get.put(injector());
    final TextEditingController _emailController = useTextEditingController();
    final TextEditingController _passwordController = useTextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        decoration: const InputDecoration(labelText: "Enter your email"),
                        validator: (String? value) {
                          if (!EmailValidator.validate(value ?? "")) {
                            return "Please input correct email";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(labelText: "Enter your password"),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please input password";
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
                  child: Obx(() => _authController.isLogging.value
                      ? const CircularProgressIndicator(
                          color: primaryColor,
                        )
                      : const Text(
                          'Email login',
                        )),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
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
                    'Google login',
                  ),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
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
                      'Forget password?',
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
                        ' Find password.',
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
                      'Don\'t have an account?',
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
                        ' Signup.',
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
