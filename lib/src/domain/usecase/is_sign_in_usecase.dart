import 'package:artitecture/src/domain/repository/auth_repository.dart';

class IsSignInUseCase {
  final AuthRepository authRepository;

  IsSignInUseCase(this.authRepository);

  Future<bool> call() async {
    return authRepository.isSignIn();
  }
}