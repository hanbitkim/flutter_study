import 'package:artitecture/src/core/storage/secure_storage.dart';
import 'package:artitecture/src/data/repository/app_repository_impl.dart';
import 'package:artitecture/src/data/repository/auth_repository_impl.dart';
import 'package:artitecture/src/data/source/remote/firebase_auth_api.dart';
import 'package:artitecture/src/domain/repository/app_repository.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';
import 'package:artitecture/src/domain/usecase/check_app_version_usecase.dart';
import 'package:artitecture/src/domain/usecase/get_user_usecase.dart';
import 'package:artitecture/src/domain/usecase/google_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/is_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/reset_password_usecase.dart';
import 'package:artitecture/src/domain/usecase/secession_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_out_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_up_usecase.dart';
import 'package:artitecture/src/presentation/controller/app_controller.dart';
import 'package:artitecture/src/presentation/controller/auth_controller.dart';
import 'package:artitecture/src/presentation/controller/edit_profile_controller.dart';
import 'package:artitecture/src/presentation/controller/main_controller.dart';
import 'package:artitecture/src/presentation/controller/mypage_controller.dart';
import 'package:artitecture/src/presentation/controller/reset_password_controller.dart';
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
  injector.registerSingleton(FirebaseAuthApi());

  // Repositories
  injector.registerSingleton<AuthRepository>(AuthRepositoryImpl(injector()));
  injector.registerSingleton<AppRepository>(AppRepositoryImpl(injector()));

  // UseCases
  injector.registerLazySingleton<IsSignedUseCase>(() => IsSignedUseCase(injector()));
  injector.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(injector()));
  injector.registerLazySingleton<SignInUseCase>(() => SignInUseCase(injector()));
  injector.registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase(injector()));
  injector.registerLazySingleton<GoogleSignInUseCase>(() => GoogleSignInUseCase(injector()));
  injector.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(injector()));
  injector.registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(injector()));
  injector.registerLazySingleton<SecessionUseCase>(() => SecessionUseCase(injector()));
  injector.registerLazySingleton<CheckAppVersionUseCase>(() => CheckAppVersionUseCase(injector()));

  // Controllers
  injector.registerFactory<AppController>(() => AppController(injector(), injector(), injector(), injector()));
  injector.registerFactory<AuthController>(() => AuthController(injector(), injector(), injector(), injector()));
  injector.registerFactory<ResetPasswordController>(() => ResetPasswordController(injector()));
  injector.registerFactory<EditProfileController>(() => EditProfileController());
  injector.registerFactory<MainController>(() => MainController());
  injector.registerFactory<MyPageController>(() => MyPageController(injector(), injector()));

  // injector.registerFactory<AuthController>(() {
  //   final autoController = AuthController(injector(), injector());
  //   Get.put(autoController);
  //   return autoController;
  // });
}