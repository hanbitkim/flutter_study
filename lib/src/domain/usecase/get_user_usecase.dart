import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/response/user.dart';
import 'package:artitecture/src/domain/repository/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository authRepository;

  GetUserUseCase(this.authRepository);

  Future<ResultWrapper<User?>> call() async {
    return authRepository.getUser();
  }
}