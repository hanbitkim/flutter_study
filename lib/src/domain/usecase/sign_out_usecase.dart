import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase(this.authRepository);

  Future<ResultWrapper<bool>> call() async {
    return authRepository.signOut();
  }
}