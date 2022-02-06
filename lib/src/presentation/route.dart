import 'package:artitecture/src/presentation/view/auth/reset_password_view.dart';
import 'package:artitecture/src/presentation/view/auth/sign_in_view.dart';
import 'package:artitecture/src/presentation/view/community/article_write.dart';
import 'package:artitecture/src/presentation/view/main/main_view.dart';
import 'package:artitecture/src/presentation/view/auth/sign_up_view.dart';
import 'package:artitecture/src/presentation/view/photo/gallery.dart';
import 'package:artitecture/src/presentation/view/profile/edit_profile_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

const String signInRoute = "/";
const String signUpRoute = "/signUp";
const String findPasswordRoute = "/findPassword";
const String editProfileRoute = "/editProfile";
const String mainRoute = "/main";
const String articleWriteRoute = "/articleWrite";
const String galleryRoute = "/gallery";

class AppRoutes {
  static List<GetPage> get routes {
    return [
      GetPage(name: signInRoute, page: () => const SignInPage()),
      GetPage(name: signUpRoute, page: () => const SignUpPage()),
      GetPage(name: findPasswordRoute, page: () => const ResetPasswordPage()),
      GetPage(name: editProfileRoute, page: () => const EditProfilePage()),
      GetPage(name: mainRoute, page: () => const MainPage()),
      GetPage(name: articleWriteRoute, page: () => const ArticleWritePage()),
      GetPage(name: galleryRoute, page: () => const GalleryPage())
    ];
  }

  static Widget getPage(String? route) {
    return routes.firstWhere((element) => element.name == route).page();
  }
}