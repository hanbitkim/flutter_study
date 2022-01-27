import 'dart:async';
import 'dart:io';

import 'package:artitecture/src/core/storage/secure_storage.dart';
import 'package:artitecture/src/core/storage/storage_key.dart';
import 'package:artitecture/src/domain/usecase/check_app_version_usecase.dart';
import 'package:artitecture/src/domain/usecase/is_sign_in_usecase.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:logger/logger.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';
import 'package:version/version.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  final CheckAppVersionUseCase _checkAppVersionUseCase;
  final IsSignInUseCase _isSignInUseCase;
  final SecureStorage _secureStorage;

  final PublishSubject<Completer<bool?>> _showRequiredUpdateDialog = PublishSubject();
  PublishSubject<Completer<bool?>> get showRequiredUpdateDialog => _showRequiredUpdateDialog;

  final PublishSubject<Completer<bool?>> _showRecommendUpdateDialog = PublishSubject();
  PublishSubject<Completer<bool?>> get showRecommendUpdateDialog => _showRecommendUpdateDialog;

  AppController(this._checkAppVersionUseCase, this._isSignInUseCase, this._secureStorage);

  Future<bool> isSignIn() async {
    var response = await _checkAppVersionUseCase();
    if (response.isSuccess()) {
      var version = await PackageInfo.fromPlatform();
      Logger().d("appVersion = ${response.getData()}, currentVersion = ${version.version}");
      var currentVersion = Version.parse(version.version);
      if (currentVersion < Version.parse(response.getData().requiredVersion)) {
        final completer = Completer<bool>();
        _showRequiredUpdateDialog.add(completer);
        final update = await completer.future;
        if (update) {
          LaunchReview.launch();
          SystemNavigator.pop();
        } else {
          SystemNavigator.pop();
        }
      }
      var ignoreVersion = await _secureStorage.read(kIgnoreAppVersion);
      var latestVersion = Version.parse(response.getData().latestVersion);
      if (currentVersion < latestVersion && (ignoreVersion == null || Version.parse(ignoreVersion) < latestVersion)) {
        final completer = Completer<bool>();
        _showRecommendUpdateDialog.add(completer);
        final update = await completer.future;
        if (update) {
          LaunchReview.launch();
        } else {
          await _secureStorage.write(kIgnoreAppVersion, response.getData().latestVersion);
        }
      }
    }
    return _isSignInUseCase();
  }
}
