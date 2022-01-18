import 'package:artitecture/src/core/utils/colors.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/auth_controller.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:artitecture/src/presentation/widget/text_field_input.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ResetPasswordPage extends HookWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController _authController = injector();
    final _emailController = useTextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: const Text("Reset password")),
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
                          'Send an email to reset password',
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
                    _authController.sendResetPasswordEmail(_emailController.text);
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
