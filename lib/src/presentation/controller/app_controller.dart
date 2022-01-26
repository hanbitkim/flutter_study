import 'dart:io';

import 'package:artitecture/src/core/storage/secure_storage.dart';
import 'package:artitecture/src/core/storage/storage_key.dart';
import 'package:artitecture/src/domain/usecase/check_app_version_usecase.dart';
import 'package:artitecture/src/domain/usecase/is_sign_in_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:version/version.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  final CheckAppVersionUseCase _checkAppVersionUseCase;
  final IsSignInUseCase _isSignInUseCase;
  final SecureStorage _secureStorage;

  AppController(this._checkAppVersionUseCase, this._isSignInUseCase, this._secureStorage);

  Future<bool> isSignIn() async {
    var response = await _checkAppVersionUseCase();
    if (response.isSuccess()) {
      var version = await PackageInfo.fromPlatform();
      Logger().d("appVersion = ${response.getData()}, currentVersion = ${version.version}");
      var currentVersion = Version.parse(version.version);
      if (currentVersion < Version.parse(response.getData().requiredVersion)) {
        await _showRequiredUpdateDialog(response.getData().requiredChanges);
      }
      var ignoreVersion = await _secureStorage.read(kIgnoreAppVersion);
      var latestVersion = Version.parse(response.getData().latestVersion);
      if (currentVersion < latestVersion && (ignoreVersion == null || Version.parse(ignoreVersion) < latestVersion)) {
        await _showLatestUpdateDialog(response.getData().latestChanges, response.getData().latestVersion);
      }
    }
    return _isSignInUseCase();
  }

  Future<void> _showRequiredUpdateDialog(String message) async {
    await Get.dialog(
        AlertDialog(
          title: const Text('필수 업데이트가 있습니다'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                LaunchReview.launch();
                exit(0);
              },
              child: const Text('업데이트'),
            ),
            TextButton(
              onPressed: () => exit(0),
              child: const Text('취소'),
            ),
          ],
        ),
        barrierDismissible: false
    );
  }

  Future<void> _showLatestUpdateDialog(String message, String version) async {
    await Get.dialog(
        AlertDialog(
          title: const Text('업데이트가 있습니다'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.back();
                LaunchReview.launch();
              },
              child: const Text('업데이트'),
            ),
            TextButton(
              onPressed: () async {
                Get.back();
                await _secureStorage.write(kIgnoreAppVersion, version);
              },
              child: const Text('다시 보지 않기'),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('다음에'),
            ),
          ],
        ),
        barrierDismissible: true
    );
  }
}
