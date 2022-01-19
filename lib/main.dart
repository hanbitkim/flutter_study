import 'package:artitecture/src/config/theme/AppTheme.dart';
import 'package:artitecture/src/core/utils/constants.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/auth_controller.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:artitecture/src/presentation/view/auth/sign_in_view.dart';
import 'package:artitecture/src/presentation/view/main/main_view.dart';
import 'package:artitecture/src/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthController authController = injector();

    return GetMaterialApp(
      title: kMaterialAppTitle,
      theme: Apptheme.light,
      getPages: AppRoutes.routes,
      home: FutureBuilder<bool>(
        future: authController.isSignIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData || snapshot.hasError) {
            if (snapshot.data == true) {
              return const MainPage();
            } else {
              return const LoginPage();
            }
          } else {
            return const SplashView();
          }
        }
      )
    );
  }
}