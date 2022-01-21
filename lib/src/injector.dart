import 'package:artitecture/src/data/repository/auth_repository_impl.dart';
import 'package:artitecture/src/data/source/remote/firebase_auth_api.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';
import 'package:artitecture/src/domain/usecase/google_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/is_sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/reset_password_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_in_usecase.dart';
import 'package:artitecture/src/domain/usecase/sign_up_usecase.dart';
import 'package:artitecture/src/presentation/controller/auth_controller.dart';
import 'package:artitecture/src/presentation/controller/main_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import '../firebase_options.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  //External
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  injector.registerLazySingleton(() => FirebaseAuth.instance);

  // Sources
  injector.registerSingleton(FirebaseAuthApi(injector()));

  // Repositories
  injector.registerSingleton<AuthRepository>(AuthRepositoryImpl(injector()));

  // UseCases
  injector.registerLazySingleton<IsSignInUseCase>(() => IsSignInUseCase(injector()));
  injector.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(injector()));
  injector.registerLazySingleton<SignInUseCase>(() => SignInUseCase(injector()));
  injector.registerLazySingleton<ResetPasswordUseCase>(() => ResetPasswordUseCase(injector()));
  injector.registerLazySingleton<GoogleSignInUseCase>(() => GoogleSignInUseCase(injector()));

  // Controllers
  injector.registerFactory<AuthController>(() => AuthController(injector(), injector(), injector(), injector(), injector()));
  injector.registerFactory<MainController>(() => MainController());

  // injector.registerFactory<AuthController>(() {
  //   final autoController = AuthController(injector(), injector());
  //   Get.put(autoController);
  //   return autoController;
  // });
}