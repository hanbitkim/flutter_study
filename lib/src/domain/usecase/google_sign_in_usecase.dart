import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';

class GoogleSignInUseCase {
  final AuthRepository authRepository;

  GoogleSignInUseCase(this.authRepository);

  Future<ResultWrapper> call() async {
    return authRepository.googleSignIn();
  }
}