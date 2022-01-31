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
}