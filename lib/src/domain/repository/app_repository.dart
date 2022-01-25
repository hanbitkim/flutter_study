import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/response/app_version.dart';

abstract class AppRepository {
  Future<ResultWrapper<AppVersion>> getAppVersion();
}