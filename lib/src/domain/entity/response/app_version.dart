import 'package:artitecture/src/core/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_version.freezed.dart';

@freezed
class AppVersion with _$AppVersion {
  factory AppVersion({
    required String requiredVersion,
    required String requiredChanges,
    required String latestVersion,
    required String latestChanges,
  }) = _AppVersion;

  factory AppVersion.fromDocument(DocumentSnapshot documentSnapshot) {
    return AppVersion(
      requiredVersion: documentSnapshot[kRequiredVersionKey],
      requiredChanges: documentSnapshot[kRequiredChangesKey],
      latestVersion: documentSnapshot[kLatestVersionKey],
      latestChanges: documentSnapshot[kLatestChangesKey],
    );
  }
}
