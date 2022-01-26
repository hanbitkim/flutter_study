import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  IOSOptions _getIOSOptions() => const IOSOptions(
    accessibility: IOSAccessibility.first_unlock,
  );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  Future<String?> read(String key) {
    return _storage.read(
      key: key,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions()
    );
  }

  Future<void> write(String key, String value) {
    return _storage.write(
      key: key,
      value: value,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions()
    );
  }
}