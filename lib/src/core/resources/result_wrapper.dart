import 'package:artitecture/src/core/resources/data_error.dart';

abstract class ResultWrapper<T> {
  final T? data;
  final DataError? error;

  const ResultWrapper({this.data, this.error});

  bool isSuccess() {
    return this is Success;
  }

  T getData() {
    if (isSuccess()) {
      return data!;
    }
    throw UnsupportedError("getData is not supported when is not succeed");
  }
}

class Success<T> extends ResultWrapper<T> {
  const Success(T? data) : super(data: data);
}

class Failure<T> extends ResultWrapper<T> {
  const Failure(DataError error) : super(error: error);
}