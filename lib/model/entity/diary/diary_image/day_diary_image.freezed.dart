// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'diary_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DiaryImage _$DiaryImageFromJson(Map<String, dynamic> json) {
  return _DiaryImage.fromJson(json);
}

/// @nodoc
class _$DiaryImageTearOff {
  const _$DiaryImageTearOff();

  _DiaryImage call(
      {required StorageFile image,
      int width = 1,
      int height = 1,
      bool isFavorite = false,
      @createdAtKey required DateTime createdAt,
      @updatedAtKey required DateTime updatedAt}) {
    return _DiaryImage(
      image: image,
      width: width,
      height: height,
      isFavorite: isFavorite,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  DiaryImage fromJson(Map<String, Object> json) {
    return DiaryImage.fromJson(json);
  }
}

/// @nodoc
const $DiaryImage = _$DiaryImageTearOff();

/// @nodoc
mixin _$DiaryImage {
  StorageFile get image => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  @createdAtKey
  DateTime get createdAt => throw _privateConstructorUsedError;
  @updatedAtKey
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryImageCopyWith<DiaryImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryImageCopyWith<$Res> {
  factory $DiaryImageCopyWith(
          DiaryImage value, $Res Function(DiaryImage) then) =
      _$DiaryImageCopyWithImpl<$Res>;
  $Res call(
      {StorageFile image,
      int width,
      int height,
      bool isFavorite,
      @createdAtKey DateTime createdAt,
      @updatedAtKey DateTime updatedAt});

  $StorageFileCopyWith<$Res> get image;
}

/// @nodoc
class _$DiaryImageCopyWithImpl<$Res> implements $DiaryImageCopyWith<$Res> {
  _$DiaryImageCopyWithImpl(this._value, this._then);

  final DiaryImage _value;
  // ignore: unused_field
  final $Res Function(DiaryImage) _then;

  @override
  $Res call({
    Object? image = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? isFavorite = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as StorageFile,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  @override
  $StorageFileCopyWith<$Res> get image {
    return $StorageFileCopyWith<$Res>(_value.image, (value) {
      return _then(_value.copyWith(image: value));
    });
  }
}

/// @nodoc
abstract class _$DiaryImageCopyWith<$Res> implements $DiaryImageCopyWith<$Res> {
  factory _$DiaryImageCopyWith(
          _DiaryImage value, $Res Function(_DiaryImage) then) =
      __$DiaryImageCopyWithImpl<$Res>;
  @override
  $Res call(
      {StorageFile image,
      int width,
      int height,
      bool isFavorite,
      @createdAtKey DateTime createdAt,
      @updatedAtKey DateTime updatedAt});

  @override
  $StorageFileCopyWith<$Res> get image;
}

/// @nodoc
class __$DiaryImageCopyWithImpl<$Res> extends _$DiaryImageCopyWithImpl<$Res>
    implements _$DiaryImageCopyWith<$Res> {
  __$DiaryImageCopyWithImpl(
      _DiaryImage _value, $Res Function(_DiaryImage) _then)
      : super(_value, (v) => _then(v as _DiaryImage));

  @override
  _DiaryImage get _value => super._value as _DiaryImage;

  @override
  $Res call({
    Object? image = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? isFavorite = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_DiaryImage(
      image: image == freezed
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as StorageFile,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DiaryImage implements _DiaryImage {
  const _$_DiaryImage(
      {required this.image,
      this.width = 1,
      this.height = 1,
      this.isFavorite = false,
      @createdAtKey required this.createdAt,
      @updatedAtKey required this.updatedAt});

  factory _$_DiaryImage.fromJson(Map<String, dynamic> json) =>
      _$_$_DiaryImageFromJson(json);

  @override
  final StorageFile image;
  @JsonKey(defaultValue: 1)
  @override
  final int width;
  @JsonKey(defaultValue: 1)
  @override
  final int height;
  @JsonKey(defaultValue: false)
  @override
  final bool isFavorite;
  @override
  @createdAtKey
  final DateTime createdAt;
  @override
  @updatedAtKey
  final DateTime updatedAt;

  @override
  String toString() {
    return 'DiaryImage(image: $image, width: $width, height: $height, isFavorite: $isFavorite, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DiaryImage &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)) &&
            (identical(other.isFavorite, isFavorite) ||
                const DeepCollectionEquality()
                    .equals(other.isFavorite, isFavorite)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(image) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height) ^
      const DeepCollectionEquality().hash(isFavorite) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt);

  @JsonKey(ignore: true)
  @override
  _$DiaryImageCopyWith<_DiaryImage> get copyWith =>
      __$DiaryImageCopyWithImpl<_DiaryImage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DiaryImageToJson(this);
  }
}

abstract class _DiaryImage implements DiaryImage {
  const factory _DiaryImage(
      {required StorageFile image,
      int width,
      int height,
      bool isFavorite,
      @createdAtKey required DateTime createdAt,
      @updatedAtKey required DateTime updatedAt}) = _$_DiaryImage;

  factory _DiaryImage.fromJson(Map<String, dynamic> json) =
      _$_DiaryImage.fromJson;

  @override
  StorageFile get image => throw _privateConstructorUsedError;
  @override
  int get width => throw _privateConstructorUsedError;
  @override
  int get height => throw _privateConstructorUsedError;
  @override
  bool get isFavorite => throw _privateConstructorUsedError;
  @override
  @createdAtKey
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  @updatedAtKey
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DiaryImageCopyWith<_DiaryImage> get copyWith =>
      throw _privateConstructorUsedError;
}
