// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_version.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AppVersionTearOff {
  const _$AppVersionTearOff();

  _AppVersion call(
      {required String requiredVersion,
      required String requiredChanges,
      required String latestVersion,
      required String latestChanges}) {
    return _AppVersion(
      requiredVersion: requiredVersion,
      requiredChanges: requiredChanges,
      latestVersion: latestVersion,
      latestChanges: latestChanges,
    );
  }
}

/// @nodoc
const $AppVersion = _$AppVersionTearOff();

/// @nodoc
mixin _$AppVersion {
  String get requiredVersion => throw _privateConstructorUsedError;
  String get requiredChanges => throw _privateConstructorUsedError;
  String get latestVersion => throw _privateConstructorUsedError;
  String get latestChanges => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppVersionCopyWith<AppVersion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppVersionCopyWith<$Res> {
  factory $AppVersionCopyWith(
          AppVersion value, $Res Function(AppVersion) then) =
      _$AppVersionCopyWithImpl<$Res>;
  $Res call(
      {String requiredVersion,
      String requiredChanges,
      String latestVersion,
      String latestChanges});
}

/// @nodoc
class _$AppVersionCopyWithImpl<$Res> implements $AppVersionCopyWith<$Res> {
  _$AppVersionCopyWithImpl(this._value, this._then);

  final AppVersion _value;
  // ignore: unused_field
  final $Res Function(AppVersion) _then;

  @override
  $Res call({
    Object? requiredVersion = freezed,
    Object? requiredChanges = freezed,
    Object? latestVersion = freezed,
    Object? latestChanges = freezed,
  }) {
    return _then(_value.copyWith(
      requiredVersion: requiredVersion == freezed
          ? _value.requiredVersion
          : requiredVersion // ignore: cast_nullable_to_non_nullable
              as String,
      requiredChanges: requiredChanges == freezed
          ? _value.requiredChanges
          : requiredChanges // ignore: cast_nullable_to_non_nullable
              as String,
      latestVersion: latestVersion == freezed
          ? _value.latestVersion
          : latestVersion // ignore: cast_nullable_to_non_nullable
              as String,
      latestChanges: latestChanges == freezed
          ? _value.latestChanges
          : latestChanges // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AppVersionCopyWith<$Res> implements $AppVersionCopyWith<$Res> {
  factory _$AppVersionCopyWith(
          _AppVersion value, $Res Function(_AppVersion) then) =
      __$AppVersionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String requiredVersion,
      String requiredChanges,
      String latestVersion,
      String latestChanges});
}

/// @nodoc
class __$AppVersionCopyWithImpl<$Res> extends _$AppVersionCopyWithImpl<$Res>
    implements _$AppVersionCopyWith<$Res> {
  __$AppVersionCopyWithImpl(
      _AppVersion _value, $Res Function(_AppVersion) _then)
      : super(_value, (v) => _then(v as _AppVersion));

  @override
  _AppVersion get _value => super._value as _AppVersion;

  @override
  $Res call({
    Object? requiredVersion = freezed,
    Object? requiredChanges = freezed,
    Object? latestVersion = freezed,
    Object? latestChanges = freezed,
  }) {
    return _then(_AppVersion(
      requiredVersion: requiredVersion == freezed
          ? _value.requiredVersion
          : requiredVersion // ignore: cast_nullable_to_non_nullable
              as String,
      requiredChanges: requiredChanges == freezed
          ? _value.requiredChanges
          : requiredChanges // ignore: cast_nullable_to_non_nullable
              as String,
      latestVersion: latestVersion == freezed
          ? _value.latestVersion
          : latestVersion // ignore: cast_nullable_to_non_nullable
              as String,
      latestChanges: latestChanges == freezed
          ? _value.latestChanges
          : latestChanges // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_AppVersion implements _AppVersion {
  _$_AppVersion(
      {required this.requiredVersion,
      required this.requiredChanges,
      required this.latestVersion,
      required this.latestChanges});

  @override
  final String requiredVersion;
  @override
  final String requiredChanges;
  @override
  final String latestVersion;
  @override
  final String latestChanges;

  @override
  String toString() {
    return 'AppVersion(requiredVersion: $requiredVersion, requiredChanges: $requiredChanges, latestVersion: $latestVersion, latestChanges: $latestChanges)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppVersion &&
            const DeepCollectionEquality()
                .equals(other.requiredVersion, requiredVersion) &&
            const DeepCollectionEquality()
                .equals(other.requiredChanges, requiredChanges) &&
            const DeepCollectionEquality()
                .equals(other.latestVersion, latestVersion) &&
            const DeepCollectionEquality()
                .equals(other.latestChanges, latestChanges));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(requiredVersion),
      const DeepCollectionEquality().hash(requiredChanges),
      const DeepCollectionEquality().hash(latestVersion),
      const DeepCollectionEquality().hash(latestChanges));

  @JsonKey(ignore: true)
  @override
  _$AppVersionCopyWith<_AppVersion> get copyWith =>
      __$AppVersionCopyWithImpl<_AppVersion>(this, _$identity);
}

abstract class _AppVersion implements AppVersion {
  factory _AppVersion(
      {required String requiredVersion,
      required String requiredChanges,
      required String latestVersion,
      required String latestChanges}) = _$_AppVersion;

  @override
  String get requiredVersion;
  @override
  String get requiredChanges;
  @override
  String get latestVersion;
  @override
  String get latestChanges;
  @override
  @JsonKey(ignore: true)
  _$AppVersionCopyWith<_AppVersion> get copyWith =>
      throw _privateConstructorUsedError;
}
