import 'package:artitecture/src/domain/repository/auth_repository.dart';

class SignInUseCase {
  final AuthRepository authRepository;

  SignInUseCase(this.authRepository);

  Future<void> call() async {
    return authRepository.signIn();
  }
}