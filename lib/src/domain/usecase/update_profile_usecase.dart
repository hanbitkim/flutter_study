import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/param/update_profile_param.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository authRepository;

  UpdateProfileUseCase(this.authRepository);

  Future<ResultWrapper> call(UpdateProfileParam param) async {
    return authRepository.updateProfile(param);
  }
}