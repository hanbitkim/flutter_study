import 'package:artitecture/src/domain/entity/response/app_version.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

extension AppVersionExtension on DocumentSnapshot {
  AppVersion toAppVersion() {
    return AppVersion(
        requiredVersion: get('required_version'),
        requiredChanges: get('required_changes'),
        latestVersion: get('latest_version'),
        latestChanges: get('latest_changes')
    );
  }
}