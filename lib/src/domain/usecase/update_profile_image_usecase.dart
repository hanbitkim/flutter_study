import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';

class UpdateProfileImageUseCase {
  final AuthRepository authRepository;

  UpdateProfileImageUseCase(this.authRepository);

  Future<ResultWrapper> call(String path) async {
    return authRepository.updateProfileImage(path);
  }
}