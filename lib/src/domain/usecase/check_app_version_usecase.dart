import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/response/app_version.dart';
import 'package:artitecture/src/domain/repository/app_repository.dart';

class CheckAppVersionUseCase {
  final AppRepository _appRepository;

  CheckAppVersionUseCase(this._appRepository);

  Future<ResultWrapper<AppVersion>> call() async {
    return _appRepository.getAppVersion();
  }
}