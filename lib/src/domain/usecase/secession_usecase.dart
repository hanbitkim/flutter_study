import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';

class SecessionUseCase {
  final AuthRepository authRepository;

  SecessionUseCase(this.authRepository);

  Future<ResultWrapper> call() async {
    return authRepository.secession();
  }
}