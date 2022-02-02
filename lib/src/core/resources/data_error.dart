class DataError {
  final int code;
  final String message;

  DataError(this.code, this.message);

  @override
  String toString() {
    return 'error code = $code, message = $message';
  }
}