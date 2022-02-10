import 'dart:async';

import 'package:artitecture/src/core/global.dart';
import 'package:artitecture/src/core/storage/secure_storage.dart';
import 'package:artitecture/src/core/storage/storage_key.dart';
import 'package:artitecture/src/domain/usecase/check_app_version_usecase.dart';
import 'package:artitecture/src/domain/usecase/get_user_usecase.dart';
import 'package:artitecture/src/domain/usecase/is_sign_in_usecase.dart';
import 'package:artitecture/src/presentation/route.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:rxdart/rxdart.dart';
import 'package:version/version.dart';

class AppController extends GetxController {
  static AppController get to => Get.find();

  final CheckAppVersionUseCase _checkAppVersionUseCase;
  final IsSignedUseCase _isSignedUseCase;
  final GetUserUseCase _getUserUseCase;
  final SecureStorage _secureStorage;

  final PublishSubject<Completer<bool?>> _showRequiredUpdateDialog = PublishSubject();

  PublishSubject<Completer<bool?>> get showRequiredUpdateDialog => _showRequiredUpdateDialog;

  final PublishSubject<Completer<bool?>> _showRecommendUpdateDialog = PublishSubject();

  PublishSubject<Completer<bool?>> get showRecommendUpdateDialog => _showRecommendUpdateDialog;

  late final Future<String> isInitialized = initialize();

  AppController(this._checkAppVersionUseCase, this._isSignedUseCase, this._secureStorage, this._getUserUseCase);

  Future<String> initialize() async {
    var response = await _checkAppVersionUseCase();
    if (response.isSuccess()) {
      var version = await PackageInfo.fromPlatform();
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
    final isSigned = await _isSignedUseCase();
    if (isSigned) {
      final userResponse = await _getUserUseCase();
      if (userResponse.isSuccess()) {
        user.value = userResponse.getData();
        if (userResponse.getData()?.isApproved == true) {
          return mainRoute;
        } else {
          return editProfileRoute;
        }
      } else {
        return signInRoute;
      }
    } else {
      return signInRoute;
    }
  }
}
