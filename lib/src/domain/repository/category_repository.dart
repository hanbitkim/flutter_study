import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:artitecture/src/domain/entity/response/category.dart';

abstract class CategoryRepository {
  Future<ResultWrapper<List<Category>>> getCategories();
}