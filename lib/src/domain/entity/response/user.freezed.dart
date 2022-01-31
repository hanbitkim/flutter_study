// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {required String? nickname,
      required String? email,
      required String? profileUrl,
      required bool? isApproved}) {
    return _User(
      nickname: nickname,
      email: email,
      profileUrl: profileUrl,
      isApproved: isApproved,
    );
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  String? get nickname => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get profileUrl => throw _privateConstructorUsedError;
  bool? get isApproved => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String? nickname, String? email, String? profileUrl, bool? isApproved});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? nickname = freezed,
    Object? email = freezed,
    Object? profileUrl = freezed,
    Object? isApproved = freezed,
  }) {
    return _then(_value.copyWith(
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profileUrl: profileUrl == freezed
          ? _value.profileUrl
          : profileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: isApproved == freezed
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? nickname, String? email, String? profileUrl, bool? isApproved});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? nickname = freezed,
    Object? email = freezed,
    Object? profileUrl = freezed,
    Object? isApproved = freezed,
  }) {
    return _then(_User(
      nickname: nickname == freezed
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profileUrl: profileUrl == freezed
          ? _value.profileUrl
          : profileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isApproved: isApproved == freezed
          ? _value.isApproved
          : isApproved // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

class _$_User implements _User {
  _$_User(
      {required this.nickname,
      required this.email,
      required this.profileUrl,
      required this.isApproved});

  @override
  final String? nickname;
  @override
  final String? email;
  @override
  final String? profileUrl;
  @override
  final bool? isApproved;

  @override
  String toString() {
    return 'User(nickname: $nickname, email: $email, profileUrl: $profileUrl, isApproved: $isApproved)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            const DeepCollectionEquality().equals(other.nickname, nickname) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality()
                .equals(other.profileUrl, profileUrl) &&
            const DeepCollectionEquality()
                .equals(other.isApproved, isApproved));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(nickname),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(profileUrl),
      const DeepCollectionEquality().hash(isApproved));

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);
}

abstract class _User implements User {
  factory _User(
      {required String? nickname,
      required String? email,
      required String? profileUrl,
      required bool? isApproved}) = _$_User;

  @override
  String? get nickname;
  @override
  String? get email;
  @override
  String? get profileUrl;
  @override
  bool? get isApproved;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}
