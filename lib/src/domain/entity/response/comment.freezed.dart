// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
class _$CommentTearOff {
  const _$CommentTearOff();

  _Comment call(
      {required String? id,
      required String? contents,
      required List<Image> images,
      required int likeCount,
      required bool isReported,
      required int createdDate,
      required int updatedDate,
      required Author author}) {
    return _Comment(
      id: id,
      contents: contents,
      images: images,
      likeCount: likeCount,
      isReported: isReported,
      createdDate: createdDate,
      updatedDate: updatedDate,
      author: author,
    );
  }

  Comment fromJson(Map<String, Object?> json) {
    return Comment.fromJson(json);
  }
}

/// @nodoc
const $Comment = _$CommentTearOff();

/// @nodoc
mixin _$Comment {
  String? get id => throw _privateConstructorUsedError;
  String? get contents => throw _privateConstructorUsedError;
  List<Image> get images => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  bool get isReported => throw _privateConstructorUsedError;
  int get createdDate => throw _privateConstructorUsedError;
  int get updatedDate => throw _privateConstructorUsedError;
  Author get author => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res>;
  $Res call(
      {String? id,
      String? contents,
      List<Image> images,
      int likeCount,
      bool isReported,
      int createdDate,
      int updatedDate,
      Author author});

  $AuthorCopyWith<$Res> get author;
}

/// @nodoc
class _$CommentCopyWithImpl<$Res> implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  final Comment _value;
  // ignore: unused_field
  final $Res Function(Comment) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? contents = freezed,
    Object? images = freezed,
    Object? likeCount = freezed,
    Object? isReported = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? author = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      contents: contents == freezed
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String?,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<Image>,
      likeCount: likeCount == freezed
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      isReported: isReported == freezed
          ? _value.isReported
          : isReported // ignore: cast_nullable_to_non_nullable
              as bool,
      createdDate: createdDate == freezed
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as int,
      updatedDate: updatedDate == freezed
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as int,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author,
    ));
  }

  @override
  $AuthorCopyWith<$Res> get author {
    return $AuthorCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value));
    });
  }
}

/// @nodoc
abstract class _$CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$CommentCopyWith(_Comment value, $Res Function(_Comment) then) =
      __$CommentCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? id,
      String? contents,
      List<Image> images,
      int likeCount,
      bool isReported,
      int createdDate,
      int updatedDate,
      Author author});

  @override
  $AuthorCopyWith<$Res> get author;
}

/// @nodoc
class __$CommentCopyWithImpl<$Res> extends _$CommentCopyWithImpl<$Res>
    implements _$CommentCopyWith<$Res> {
  __$CommentCopyWithImpl(_Comment _value, $Res Function(_Comment) _then)
      : super(_value, (v) => _then(v as _Comment));

  @override
  _Comment get _value => super._value as _Comment;

  @override
  $Res call({
    Object? id = freezed,
    Object? contents = freezed,
    Object? images = freezed,
    Object? likeCount = freezed,
    Object? isReported = freezed,
    Object? createdDate = freezed,
    Object? updatedDate = freezed,
    Object? author = freezed,
  }) {
    return _then(_Comment(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      contents: contents == freezed
          ? _value.contents
          : contents // ignore: cast_nullable_to_non_nullable
              as String?,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<Image>,
      likeCount: likeCount == freezed
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      isReported: isReported == freezed
          ? _value.isReported
          : isReported // ignore: cast_nullable_to_non_nullable
              as bool,
      createdDate: createdDate == freezed
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as int,
      updatedDate: updatedDate == freezed
          ? _value.updatedDate
          : updatedDate // ignore: cast_nullable_to_non_nullable
              as int,
      author: author == freezed
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as Author,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Comment implements _Comment {
  _$_Comment(
      {required this.id,
      required this.contents,
      required this.images,
      required this.likeCount,
      required this.isReported,
      required this.createdDate,
      required this.updatedDate,
      required this.author});

  factory _$_Comment.fromJson(Map<String, dynamic> json) =>
      _$$_CommentFromJson(json);

  @override
  final String? id;
  @override
  final String? contents;
  @override
  final List<Image> images;
  @override
  final int likeCount;
  @override
  final bool isReported;
  @override
  final int createdDate;
  @override
  final int updatedDate;
  @override
  final Author author;

  @override
  String toString() {
    return 'Comment(id: $id, contents: $contents, images: $images, likeCount: $likeCount, isReported: $isReported, createdDate: $createdDate, updatedDate: $updatedDate, author: $author)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Comment &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.contents, contents) &&
            const DeepCollectionEquality().equals(other.images, images) &&
            const DeepCollectionEquality().equals(other.likeCount, likeCount) &&
            const DeepCollectionEquality()
                .equals(other.isReported, isReported) &&
            const DeepCollectionEquality()
                .equals(other.createdDate, createdDate) &&
            const DeepCollectionEquality()
                .equals(other.updatedDate, updatedDate) &&
            const DeepCollectionEquality().equals(other.author, author));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(contents),
      const DeepCollectionEquality().hash(images),
      const DeepCollectionEquality().hash(likeCount),
      const DeepCollectionEquality().hash(isReported),
      const DeepCollectionEquality().hash(createdDate),
      const DeepCollectionEquality().hash(updatedDate),
      const DeepCollectionEquality().hash(author));

  @JsonKey(ignore: true)
  @override
  _$CommentCopyWith<_Comment> get copyWith =>
      __$CommentCopyWithImpl<_Comment>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CommentToJson(this);
  }
}

abstract class _Comment implements Comment {
  factory _Comment(
      {required String? id,
      required String? contents,
      required List<Image> images,
      required int likeCount,
      required bool isReported,
      required int createdDate,
      required int updatedDate,
      required Author author}) = _$_Comment;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$_Comment.fromJson;

  @override
  String? get id;
  @override
  String? get contents;
  @override
  List<Image> get images;
  @override
  int get likeCount;
  @override
  bool get isReported;
  @override
  int get createdDate;
  @override
  int get updatedDate;
  @override
  Author get author;
  @override
  @JsonKey(ignore: true)
  _$CommentCopyWith<_Comment> get copyWith =>
      throw _privateConstructorUsedError;
}
