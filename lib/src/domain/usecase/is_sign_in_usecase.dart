import 'package:artitecture/src/domain/repository/auth_repository.dart';

class IsSignedUseCase {
  final AuthRepository authRepository;

  IsSignedUseCase(this.authRepository);

  Future<bool> call() async {
    return authRepository.isSigned();
  }
}