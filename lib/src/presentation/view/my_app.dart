import 'package:artitecture/src/config/theme/AppTheme.dart';
import 'package:artitecture/src/core/utils/constants.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/app_controller.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:artitecture/src/presentation/view/auth/sign_in_view.dart';
import 'package:artitecture/src/presentation/view/main/main_view.dart';
import 'package:artitecture/src/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController _appController = Get.put(injector());

    return GetMaterialApp(
        title: kMaterialAppTitle,
        theme: Apptheme.light,
        getPages: AppRoutes.routes,
        home: FutureBuilder<bool>(
            future: _appController.isSignIn(),
            builder: (context, snapshot) {
              if (snapshot.hasError || snapshot.hasData) {
                if (snapshot.data == true) {
                  return const MainPage();
                } else {
                  return const SignInPage();
                }
              } else {
                return const SplashView();
              }
            }
        )
    );
  }
}