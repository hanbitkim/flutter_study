import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/data/source/remote/firebase_auth_api.dart';
import 'package:artitecture/src/domain/entity/response/app_version.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/domain/repository/app_repository.dart';
import 'package:artitecture/src/domain/repository/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final FirebaseApi _firebaseApi;

  CategoryRepositoryImpl(this._firebaseApi);

  @override
  Future<ResultWrapper<List<Category>>> getCategories() {
    return _firebaseApi.getCategories();
  }
}