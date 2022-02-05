import 'package:artitecture/src/core/resources/data_error.dart';
import 'package:artitecture/src/core/resources/error_code.dart';
import 'package:artitecture/src/core/resources/result_wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class ResultHandler<T> {
  Future<ResultWrapper<T>> invoke(Function function) async {
    try {
      final result = await function.call();
      Logger().d('result = $result');
      return Success(result);
    } on FirebaseException catch (e) {
      Logger().d("exception = ${e.code}");
      return Failure(DataError(error, e.code));
    }
  }
}