import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';
import 'package:artitecture/src/domain/repository/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository _categoryRepository;

  GetCategoriesUseCase(this._categoryRepository);

  Future<ResultWrapper<List<Category>>> call() async {
    return _categoryRepository.getCategories();
  }
}