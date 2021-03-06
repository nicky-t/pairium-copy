// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'diary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Diary _$DiaryFromJson(Map<String, dynamic> json) {
  return _Diary.fromJson(json);
}

/// @nodoc
class _$DiaryTearOff {
  const _$DiaryTearOff();

  _Diary call(
      {@dateKey required DateTime date,
      required int year,
      required int month,
      required int day,
      required StorageFile mainImage,
      required List<String> userIds,
      String title = '',
      String description = '',
      Weather? weather,
      String? tag,
      List<DiaryImage> images = const <DiaryImage>[],
      bool isFavorite = false,
      @createdAtKey required DateTime createdAt,
      @updatedAtKey required DateTime updatedAt}) {
    return _Diary(
      date: date,
      year: year,
      month: month,
      day: day,
      mainImage: mainImage,
      userIds: userIds,
      title: title,
      description: description,
      weather: weather,
      tag: tag,
      images: images,
      isFavorite: isFavorite,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Diary fromJson(Map<String, Object> json) {
    return Diary.fromJson(json);
  }
}

/// @nodoc
const $Diary = _$DiaryTearOff();

/// @nodoc
mixin _$Diary {
  @dateKey
  DateTime get date => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get month => throw _privateConstructorUsedError;
  int get day => throw _privateConstructorUsedError;
  StorageFile get mainImage => throw _privateConstructorUsedError;
  List<String> get userIds => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Weather? get weather => throw _privateConstructorUsedError;
  String? get tag => throw _privateConstructorUsedError;
  List<DiaryImage> get images => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  @createdAtKey
  DateTime get createdAt => throw _privateConstructorUsedError;
  @updatedAtKey
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryCopyWith<Diary> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryCopyWith<$Res> {
  factory $DiaryCopyWith(Diary value, $Res Function(Diary) then) =
      _$DiaryCopyWithImpl<$Res>;
  $Res call(
      {@dateKey DateTime date,
      int year,
      int month,
      int day,
      StorageFile mainImage,
      List<String> userIds,
      String title,
      String description,
      Weather? weather,
      String? tag,
      List<DiaryImage> images,
      bool isFavorite,
      @createdAtKey DateTime createdAt,
      @updatedAtKey DateTime updatedAt});

  $StorageFileCopyWith<$Res> get mainImage;
}

/// @nodoc
class _$DiaryCopyWithImpl<$Res> implements $DiaryCopyWith<$Res> {
  _$DiaryCopyWithImpl(this._value, this._then);

  final Diary _value;
  // ignore: unused_field
  final $Res Function(Diary) _then;

  @override
  $Res call({
    Object? date = freezed,
    Object? year = freezed,
    Object? month = freezed,
    Object? day = freezed,
    Object? mainImage = freezed,
    Object? userIds = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? weather = freezed,
    Object? tag = freezed,
    Object? images = freezed,
    Object? isFavorite = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      day: day == freezed
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      mainImage: mainImage == freezed
          ? _value.mainImage
          : mainImage // ignore: cast_nullable_to_non_nullable
              as StorageFile,
      userIds: userIds == freezed
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      weather: weather == freezed
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as Weather?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<DiaryImage>,
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
  $StorageFileCopyWith<$Res> get mainImage {
    return $StorageFileCopyWith<$Res>(_value.mainImage, (value) {
      return _then(_value.copyWith(mainImage: value));
    });
  }
}

/// @nodoc
abstract class _$DiaryCopyWith<$Res> implements $DiaryCopyWith<$Res> {
  factory _$DiaryCopyWith(_Diary value, $Res Function(_Diary) then) =
      __$DiaryCopyWithImpl<$Res>;
  @override
  $Res call(
      {@dateKey DateTime date,
      int year,
      int month,
      int day,
      StorageFile mainImage,
      List<String> userIds,
      String title,
      String description,
      Weather? weather,
      String? tag,
      List<DiaryImage> images,
      bool isFavorite,
      @createdAtKey DateTime createdAt,
      @updatedAtKey DateTime updatedAt});

  @override
  $StorageFileCopyWith<$Res> get mainImage;
}

/// @nodoc
class __$DiaryCopyWithImpl<$Res> extends _$DiaryCopyWithImpl<$Res>
    implements _$DiaryCopyWith<$Res> {
  __$DiaryCopyWithImpl(_Diary _value, $Res Function(_Diary) _then)
      : super(_value, (v) => _then(v as _Diary));

  @override
  _Diary get _value => super._value as _Diary;

  @override
  $Res call({
    Object? date = freezed,
    Object? year = freezed,
    Object? month = freezed,
    Object? day = freezed,
    Object? mainImage = freezed,
    Object? userIds = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? weather = freezed,
    Object? tag = freezed,
    Object? images = freezed,
    Object? isFavorite = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_Diary(
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as int,
      day: day == freezed
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      mainImage: mainImage == freezed
          ? _value.mainImage
          : mainImage // ignore: cast_nullable_to_non_nullable
              as StorageFile,
      userIds: userIds == freezed
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      weather: weather == freezed
          ? _value.weather
          : weather // ignore: cast_nullable_to_non_nullable
              as Weather?,
      tag: tag == freezed
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as String?,
      images: images == freezed
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<DiaryImage>,
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
class _$_Diary implements _Diary {
  const _$_Diary(
      {@dateKey required this.date,
      required this.year,
      required this.month,
      required this.day,
      required this.mainImage,
      required this.userIds,
      this.title = '',
      this.description = '',
      this.weather,
      this.tag,
      this.images = const <DiaryImage>[],
      this.isFavorite = false,
      @createdAtKey required this.createdAt,
      @updatedAtKey required this.updatedAt});

  factory _$_Diary.fromJson(Map<String, dynamic> json) =>
      _$_$_DiaryFromJson(json);

  @override
  @dateKey
  final DateTime date;
  @override
  final int year;
  @override
  final int month;
  @override
  final int day;
  @override
  final StorageFile mainImage;
  @override
  final List<String> userIds;
  @JsonKey(defaultValue: '')
  @override
  final String title;
  @JsonKey(defaultValue: '')
  @override
  final String description;
  @override
  final Weather? weather;
  @override
  final String? tag;
  @JsonKey(defaultValue: const <DiaryImage>[])
  @override
  final List<DiaryImage> images;
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
    return 'Diary(date: $date, year: $year, month: $month, day: $day, mainImage: $mainImage, userIds: $userIds, title: $title, description: $description, weather: $weather, tag: $tag, images: $images, isFavorite: $isFavorite, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Diary &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)) &&
            (identical(other.month, month) ||
                const DeepCollectionEquality().equals(other.month, month)) &&
            (identical(other.day, day) ||
                const DeepCollectionEquality().equals(other.day, day)) &&
            (identical(other.mainImage, mainImage) ||
                const DeepCollectionEquality()
                    .equals(other.mainImage, mainImage)) &&
            (identical(other.userIds, userIds) ||
                const DeepCollectionEquality()
                    .equals(other.userIds, userIds)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.weather, weather) ||
                const DeepCollectionEquality()
                    .equals(other.weather, weather)) &&
            (identical(other.tag, tag) ||
                const DeepCollectionEquality().equals(other.tag, tag)) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)) &&
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
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(year) ^
      const DeepCollectionEquality().hash(month) ^
      const DeepCollectionEquality().hash(day) ^
      const DeepCollectionEquality().hash(mainImage) ^
      const DeepCollectionEquality().hash(userIds) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(weather) ^
      const DeepCollectionEquality().hash(tag) ^
      const DeepCollectionEquality().hash(images) ^
      const DeepCollectionEquality().hash(isFavorite) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt);

  @JsonKey(ignore: true)
  @override
  _$DiaryCopyWith<_Diary> get copyWith =>
      __$DiaryCopyWithImpl<_Diary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_DiaryToJson(this);
  }
}

abstract class _Diary implements Diary {
  const factory _Diary(
      {@dateKey required DateTime date,
      required int year,
      required int month,
      required int day,
      required StorageFile mainImage,
      required List<String> userIds,
      String title,
      String description,
      Weather? weather,
      String? tag,
      List<DiaryImage> images,
      bool isFavorite,
      @createdAtKey required DateTime createdAt,
      @updatedAtKey required DateTime updatedAt}) = _$_Diary;

  factory _Diary.fromJson(Map<String, dynamic> json) = _$_Diary.fromJson;

  @override
  @dateKey
  DateTime get date => throw _privateConstructorUsedError;
  @override
  int get year => throw _privateConstructorUsedError;
  @override
  int get month => throw _privateConstructorUsedError;
  @override
  int get day => throw _privateConstructorUsedError;
  @override
  StorageFile get mainImage => throw _privateConstructorUsedError;
  @override
  List<String> get userIds => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  Weather? get weather => throw _privateConstructorUsedError;
  @override
  String? get tag => throw _privateConstructorUsedError;
  @override
  List<DiaryImage> get images => throw _privateConstructorUsedError;
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
  _$DiaryCopyWith<_Diary> get copyWith => throw _privateConstructorUsedError;
}
