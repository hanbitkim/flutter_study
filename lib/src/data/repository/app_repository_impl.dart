import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/data/source/remote/firebase_api.dart';
import 'package:artitecture/src/domain/entity/response/app_version.dart';
import 'package:artitecture/src/domain/repository/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  final FirebaseApi firebaseAuthApi;

  AppRepositoryImpl(this.firebaseAuthApi);

  @override
  Future<ResultWrapper<AppVersion>> getAppVersion() {
    return firebaseAuthApi.getAppVersion();
  }
}