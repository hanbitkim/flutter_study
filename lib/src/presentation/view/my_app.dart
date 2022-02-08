import 'package:artitecture/src/config/theme/AppTheme.dart';
import 'package:artitecture/src/core/utils/constants.dart';
import 'package:artitecture/src/injector.dart';
import 'package:artitecture/src/presentation/controller/app_controller.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:artitecture/src/presentation/view/auth/sign_in_view.dart';
import 'package:artitecture/src/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppController _appController = Get.put(injector());
    final snapshot = useFuture(_appController.isInitialized);

    useEffect(() {
      final subscription = _appController.showRequiredUpdateDialog.listen((completer) {
        Logger().d("showRequiredUpdateDialog");
        Future<void>.microtask(() async {
          final update = await _showRequiredUpdateDialog();
          Logger().d("update = $update");
          completer.complete(update);
        });
      });
      return subscription.cancel;
    }, [_appController]);

    useEffect(() {
      final subscription = _appController.showRecommendUpdateDialog.listen((completer) {
        Logger().d("showRecommendUpdateDialog");
        Future<void>.microtask(() async {
          final update = await _showRecommendUpdateDialog();
          Logger().d("update = $update");
          completer.complete(update);
        });
      });
      return subscription.cancel;
    }, [_appController]);

    return GlobalLoaderOverlay(
      overlayColor: Colors.black,
      overlayOpacity: 0.3,
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: kMaterialAppTitle,
          theme: Apptheme.light,
          getPages: AppRoutes.routes,
          home: snapshot.hasData == false
              ? const SplashView()
              : snapshot.hasError
              ? const SignInPage()
              : AppRoutes.getPage(snapshot.data)
      ),
    );
  }

  Future<bool?> _showRequiredUpdateDialog() {
    return Get.dialog<bool>(
        WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('필수 업데이트가 있습니다'),
            content: const Text('업데이트 후 사용이 가능합니다'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text('업데이트'),
              ),
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('취소'),
              ),
            ],
          ),
        ),
        barrierDismissible: false
    );
  }

  Future<bool?> _showRecommendUpdateDialog() {
    return Get.dialog(
        WillPopScope(
          onWillPop: () async {
            Get.back(result: false);
            return false;
          },
          child: AlertDialog(
            title: const Text('업데이트가 있습니다'),
            content: const Text('최신 버전으로 업데이트를 권장합니다'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text('업데이트'),
              ),
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text('취소'),
              ),
            ],
          ),
        ),
        barrierDismissible: false
    );
  }
}