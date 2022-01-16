import 'package:artitecture/src/presentation/view/login_view.dart';
import 'package:artitecture/src/presentation/view/main_view.dart';
import 'package:get/get.dart';

const String loginRoute = "/";
const String mainRoute = "/main";

class AppRoutes {
  static List<GetPage> get routes {
    return [
      GetPage(name: loginRoute, page: () => const LoginPage()),
      GetPage(name: mainRoute, page: () => const MainPage())
    ];
  }
}