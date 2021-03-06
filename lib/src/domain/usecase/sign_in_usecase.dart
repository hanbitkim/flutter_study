import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<ResultWrapper> call(String email, String password) async {
    return authRepository.signIn(email, password);
  }
}