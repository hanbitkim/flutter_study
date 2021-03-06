import 'package:artitecture/src/core/storage/secure_storage.dart';
import 'package:artitecture/src/data/repository/app_repository_impl.dart';
import 'package:artitecture/src/data/repository/auth_repository_impl.dart';
import 'package:artitecture/src/data/repository/community_repository_impl.dart';
import 'package:artitecture/src/data/source/remote/firebase_api.dart';
import 'package:artitecture/src/domain/repository/app_repository.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';
import 'package:artitecture/src/domain/repository/community_repository.dart';
import 'package:artitecture/src/domain/usecase/check_app_version_usecase.dart';
import 'package:artitecture/src/domain/usecase/get_article_usecase.dart';
import 'package:artitecture/src/domain/usecase/get_articles_usecase.dart';
import 'package:artitecture/src/domain/usecase/get_category_usecase.dart';
import 'package:artitecture/src/domain/usecase/get_comments_usecase.dart';
import 'package:artitecture/src/domain/usecase/get_user_usecase.dart';
import 'package:artitecture/src/domain/usecase/google_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/is_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/reset_password_usecase.dart';
import 'package:artitecture/src/domain/usecase/secession_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_out_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_up_usecase.dart';
import 'package:artitecture/src/domain/usecase/update_profile_image_usecase.dart';
import 'package:artitecture/src/domain/usecase/update_profile_usecase.dart';
import 'package:artitecture/src/domain/usecase/upload_article_usecase.dart';
import 'package:artitecture/src/presentation/controller/app_controller.dart';
import 'package:artitecture/src/presentation/controller/article_detail_controller.dart';
import 'package:artitecture/src/presentation/controller/article_write_controller.dart';
import 'package:artitecture/src/presentation/controller/auth_controller.dart';
import 'package:artitecture/src/presentation/controller/board_controller.dart';
import 'package:artitecture/src/presentation/controller/edit_profile_controller.dart';
import 'package:artitecture/src/presentation/controller/find_password_controller.dart';
import 'package:artitecture/src/presentation/controller/main_controller.dart';
import 'package:artitecture/src/presentation/controller/mypage_controller.dart';
import 'package:artitecture/src/presentation/controller/setting_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import '../firebase_options.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  //External
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Storage
  injector.registerSingleton(SecureStorage());

  // Sources
  injector.registerSingleton(FirebaseApi());

  // Repositories
  injector.registerSingleton<AuthRepository>(AuthRepositoryImpl(injector()));
  injector.registerSingleton<AppRepository>(AppRepositoryImpl(injector()));
  injector.registerSingleton<CommunityRepository>(CommunityRepositoryImpl(injector()));

  // UseCases
  injector.registerLazySingleton<IsSignedUseCase>(() => IsSignedUseCase(injector()));
  injector.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(injector()));
  injector.registerLazySingleton<SignInUseCase>(() => SignInUseCase(injector()));
  injector.registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase(injector()));
  injector.registerLazySingleton<GoogleSignInUseCase>(() => GoogleSignInUseCase(injector()));
  injector.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(injector()));
  injector.registerLazySingleton<UpdateProfileUseCase>(() => UpdateProfileUseCase(injector()));
  injector.registerLazySingleton<UpdateProfileImageUseCase>(() => UpdateProfileImageUseCase(injector()));
  injector.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(injector()));
  injector.registerLazySingleton<SecessionUseCase>(() => SecessionUseCase(injector()));
  injector.registerLazySingleton<CheckAppVersionUseCase>(() => CheckAppVersionUseCase(injector()));
  injector.registerLazySingleton<GetCategoriesUseCase>(() => GetCategoriesUseCase(injector()));
  injector.registerLazySingleton<GetArticlesUseCase>(() => GetArticlesUseCase(injector()));
  injector.registerLazySingleton<UploadArticleUseCase>(() => UploadArticleUseCase(injector()));
  injector.registerLazySingleton<GetCommentsUseCase>(() => GetCommentsUseCase(injector()));
  injector.registerLazySingleton<GetArticleUseCase>(() => GetArticleUseCase(injector()));

  // Controllers
  injector.registerFactory<AppController>(() => AppController(injector(), injector(), injector(), injector()));
  injector.registerFactory<AuthController>(() => AuthController(injector(), injector(), injector(), injector()));
  injector.registerFactory<FindPasswordController>(() => FindPasswordController(injector()));
  injector.registerFactory<EditProfileController>(() => EditProfileController(injector(), injector()));
  injector.registerFactory<MainController>(() => MainController());
  injector.registerFactory<BoardController>(() => BoardController(injector()));
  injector.registerFactory<MyPageController>(() => MyPageController(injector()));
  injector.registerFactory<ArticleWriteController>(() => ArticleWriteController(injector()));
  injector.registerFactory<SettingController>(() => SettingController(injector(), injector()));
  injector.registerFactory<ArticleDetailController>(() => ArticleDetailController(injector(), injector()));

  // injector.registerFactory<AuthController>(() {
  //   final autoController = AuthController(injector(), injector());
  //   Get.put(autoController);
  //   return autoController;
  // });
}
