import 'package:artitecture/src/domain/repository/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository authRepository;

  SignOutUseCase(this.authRepository);

  Future<void> call() async {
    return authRepository.signOut();
  }
}