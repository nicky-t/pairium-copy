// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'firebase_storage_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StorageFile _$StorageFileFromJson(Map<String, dynamic> json) {
  return _StorageFile.fromJson(json);
}

/// @nodoc
class _$StorageFileTearOff {
  const _$StorageFileTearOff();

  _StorageFile call(
      {String mimeType = '',
      required String path,
      required String url,
      Map<String, Object> metadata = const <String, Object>{}}) {
    return _StorageFile(
      mimeType: mimeType,
      path: path,
      url: url,
      metadata: metadata,
    );
  }

  StorageFile fromJson(Map<String, Object> json) {
    return StorageFile.fromJson(json);
  }
}

/// @nodoc
const $StorageFile = _$StorageFileTearOff();

/// @nodoc
mixin _$StorageFile {
  String get mimeType => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  Map<String, Object> get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StorageFileCopyWith<StorageFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageFileCopyWith<$Res> {
  factory $StorageFileCopyWith(
          StorageFile value, $Res Function(StorageFile) then) =
      _$StorageFileCopyWithImpl<$Res>;
  $Res call(
      {String mimeType, String path, String url, Map<String, Object> metadata});
}

/// @nodoc
class _$StorageFileCopyWithImpl<$Res> implements $StorageFileCopyWith<$Res> {
  _$StorageFileCopyWithImpl(this._value, this._then);

  final StorageFile _value;
  // ignore: unused_field
  final $Res Function(StorageFile) _then;

  @override
  $Res call({
    Object? mimeType = freezed,
    Object? path = freezed,
    Object? url = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      mimeType: mimeType == freezed
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, Object>,
    ));
  }
}

/// @nodoc
abstract class _$StorageFileCopyWith<$Res>
    implements $StorageFileCopyWith<$Res> {
  factory _$StorageFileCopyWith(
          _StorageFile value, $Res Function(_StorageFile) then) =
      __$StorageFileCopyWithImpl<$Res>;
  @override
  $Res call(
      {String mimeType, String path, String url, Map<String, Object> metadata});
}

/// @nodoc
class __$StorageFileCopyWithImpl<$Res> extends _$StorageFileCopyWithImpl<$Res>
    implements _$StorageFileCopyWith<$Res> {
  __$StorageFileCopyWithImpl(
      _StorageFile _value, $Res Function(_StorageFile) _then)
      : super(_value, (v) => _then(v as _StorageFile));

  @override
  _StorageFile get _value => super._value as _StorageFile;

  @override
  $Res call({
    Object? mimeType = freezed,
    Object? path = freezed,
    Object? url = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_StorageFile(
      mimeType: mimeType == freezed
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, Object>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StorageFile implements _StorageFile {
  const _$_StorageFile(
      {this.mimeType = '',
      required this.path,
      required this.url,
      this.metadata = const <String, Object>{}});

  factory _$_StorageFile.fromJson(Map<String, dynamic> json) =>
      _$_$_StorageFileFromJson(json);

  @JsonKey(defaultValue: '')
  @override
  final String mimeType;
  @override
  final String path;
  @override
  final String url;
  @JsonKey(defaultValue: const <String, Object>{})
  @override
  final Map<String, Object> metadata;

  @override
  String toString() {
    return 'StorageFile(mimeType: $mimeType, path: $path, url: $url, metadata: $metadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _StorageFile &&
            (identical(other.mimeType, mimeType) ||
                const DeepCollectionEquality()
                    .equals(other.mimeType, mimeType)) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.metadata, metadata) ||
                const DeepCollectionEquality()
                    .equals(other.metadata, metadata)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(mimeType) ^
      const DeepCollectionEquality().hash(path) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(metadata);

  @JsonKey(ignore: true)
  @override
  _$StorageFileCopyWith<_StorageFile> get copyWith =>
      __$StorageFileCopyWithImpl<_StorageFile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_StorageFileToJson(this);
  }
}

abstract class _StorageFile implements StorageFile {
  const factory _StorageFile(
      {String mimeType,
      required String path,
      required String url,
      Map<String, Object> metadata}) = _$_StorageFile;

  factory _StorageFile.fromJson(Map<String, dynamic> json) =
      _$_StorageFile.fromJson;

  @override
  String get mimeType => throw _privateConstructorUsedError;
  @override
  String get path => throw _privateConstructorUsedError;
  @override
  String get url => throw _privateConstructorUsedError;
  @override
  Map<String, Object> get metadata => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$StorageFileCopyWith<_StorageFile> get copyWith =>
      throw _privateConstructorUsedError;
}
