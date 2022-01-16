import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<ResultWrapper> call(String email, String password) async {
    return authRepository.signUp(email, password);
  }
}