import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository authRepository;

  ResetPasswordUseCase(this.authRepository);

  Future<ResultWrapper> call(String email) async {
    return authRepository.resetPassword(email);
  }
}