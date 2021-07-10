// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'month_diary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MonthDiary _$MonthDiaryFromJson(Map<String, dynamic> json) {
  return _MonthDiary.fromJson(json);
}

/// @nodoc
class _$MonthDiaryTearOff {
  const _$MonthDiaryTearOff();

  _MonthDiary call(
      {required Month month,
      required int monthNumber,
      required int year,
      CardColor cardColor = CardColor.black,
      StorageFile? frontImage,
      StorageFile? backImage,
      @createdAtKey required DateTime createdAt,
      @updatedAtKey required DateTime updatedAt}) {
    return _MonthDiary(
      month: month,
      monthNumber: monthNumber,
      year: year,
      cardColor: cardColor,
      frontImage: frontImage,
      backImage: backImage,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  MonthDiary fromJson(Map<String, Object> json) {
    return MonthDiary.fromJson(json);
  }
}

/// @nodoc
const $MonthDiary = _$MonthDiaryTearOff();

/// @nodoc
mixin _$MonthDiary {
  Month get month => throw _privateConstructorUsedError;
  int get monthNumber => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  CardColor get cardColor => throw _privateConstructorUsedError;
  StorageFile? get frontImage => throw _privateConstructorUsedError;
  StorageFile? get backImage => throw _privateConstructorUsedError;
  @createdAtKey
  DateTime get createdAt => throw _privateConstructorUsedError;
  @updatedAtKey
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MonthDiaryCopyWith<MonthDiary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthDiaryCopyWith<$Res> {
  factory $MonthDiaryCopyWith(
          MonthDiary value, $Res Function(MonthDiary) then) =
      _$MonthDiaryCopyWithImpl<$Res>;
  $Res call(
      {Month month,
      int monthNumber,
      int year,
      CardColor cardColor,
      StorageFile? frontImage,
      StorageFile? backImage,
      @createdAtKey DateTime createdAt,
      @updatedAtKey DateTime updatedAt});

  $StorageFileCopyWith<$Res>? get frontImage;
  $StorageFileCopyWith<$Res>? get backImage;
}

/// @nodoc
class _$MonthDiaryCopyWithImpl<$Res> implements $MonthDiaryCopyWith<$Res> {
  _$MonthDiaryCopyWithImpl(this._value, this._then);

  final MonthDiary _value;
  // ignore: unused_field
  final $Res Function(MonthDiary) _then;

  @override
  $Res call({
    Object? month = freezed,
    Object? monthNumber = freezed,
    Object? year = freezed,
    Object? cardColor = freezed,
    Object? frontImage = freezed,
    Object? backImage = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as Month,
      monthNumber: monthNumber == freezed
          ? _value.monthNumber
          : monthNumber // ignore: cast_nullable_to_non_nullable
              as int,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      cardColor: cardColor == freezed
          ? _value.cardColor
          : cardColor // ignore: cast_nullable_to_non_nullable
              as CardColor,
      frontImage: frontImage == freezed
          ? _value.frontImage
          : frontImage // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
      backImage: backImage == freezed
          ? _value.backImage
          : backImage // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
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
  $StorageFileCopyWith<$Res>? get frontImage {
    if (_value.frontImage == null) {
      return null;
    }

    return $StorageFileCopyWith<$Res>(_value.frontImage!, (value) {
      return _then(_value.copyWith(frontImage: value));
    });
  }

  @override
  $StorageFileCopyWith<$Res>? get backImage {
    if (_value.backImage == null) {
      return null;
    }

    return $StorageFileCopyWith<$Res>(_value.backImage!, (value) {
      return _then(_value.copyWith(backImage: value));
    });
  }
}

/// @nodoc
abstract class _$MonthDiaryCopyWith<$Res> implements $MonthDiaryCopyWith<$Res> {
  factory _$MonthDiaryCopyWith(
          _MonthDiary value, $Res Function(_MonthDiary) then) =
      __$MonthDiaryCopyWithImpl<$Res>;
  @override
  $Res call(
      {Month month,
      int monthNumber,
      int year,
      CardColor cardColor,
      StorageFile? frontImage,
      StorageFile? backImage,
      @createdAtKey DateTime createdAt,
      @updatedAtKey DateTime updatedAt});

  @override
  $StorageFileCopyWith<$Res>? get frontImage;
  @override
  $StorageFileCopyWith<$Res>? get backImage;
}

/// @nodoc
class __$MonthDiaryCopyWithImpl<$Res> extends _$MonthDiaryCopyWithImpl<$Res>
    implements _$MonthDiaryCopyWith<$Res> {
  __$MonthDiaryCopyWithImpl(
      _MonthDiary _value, $Res Function(_MonthDiary) _then)
      : super(_value, (v) => _then(v as _MonthDiary));

  @override
  _MonthDiary get _value => super._value as _MonthDiary;

  @override
  $Res call({
    Object? month = freezed,
    Object? monthNumber = freezed,
    Object? year = freezed,
    Object? cardColor = freezed,
    Object? frontImage = freezed,
    Object? backImage = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_MonthDiary(
      month: month == freezed
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as Month,
      monthNumber: monthNumber == freezed
          ? _value.monthNumber
          : monthNumber // ignore: cast_nullable_to_non_nullable
              as int,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as int,
      cardColor: cardColor == freezed
          ? _value.cardColor
          : cardColor // ignore: cast_nullable_to_non_nullable
              as CardColor,
      frontImage: frontImage == freezed
          ? _value.frontImage
          : frontImage // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
      backImage: backImage == freezed
          ? _value.backImage
          : backImage // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
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
class _$_MonthDiary implements _MonthDiary {
  const _$_MonthDiary(
      {required this.month,
      required this.monthNumber,
      required this.year,
      this.cardColor = CardColor.black,
      this.frontImage,
      this.backImage,
      @createdAtKey required this.createdAt,
      @updatedAtKey required this.updatedAt});

  factory _$_MonthDiary.fromJson(Map<String, dynamic> json) =>
      _$_$_MonthDiaryFromJson(json);

  @override
  final Month month;
  @override
  final int monthNumber;
  @override
  final int year;
  @JsonKey(defaultValue: CardColor.black)
  @override
  final CardColor cardColor;
  @override
  final StorageFile? frontImage;
  @override
  final StorageFile? backImage;
  @override
  @createdAtKey
  final DateTime createdAt;
  @override
  @updatedAtKey
  final DateTime updatedAt;

  @override
  String toString() {
    return 'MonthDiary(month: $month, monthNumber: $monthNumber, year: $year, cardColor: $cardColor, frontImage: $frontImage, backImage: $backImage, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MonthDiary &&
            (identical(other.month, month) ||
                const DeepCollectionEquality().equals(other.month, month)) &&
            (identical(other.monthNumber, monthNumber) ||
                const DeepCollectionEquality()
                    .equals(other.monthNumber, monthNumber)) &&
            (identical(other.year, year) ||
                const DeepCollectionEquality().equals(other.year, year)) &&
            (identical(other.cardColor, cardColor) ||
                const DeepCollectionEquality()
                    .equals(other.cardColor, cardColor)) &&
            (identical(other.frontImage, frontImage) ||
                const DeepCollectionEquality()
                    .equals(other.frontImage, frontImage)) &&
            (identical(other.backImage, backImage) ||
                const DeepCollectionEquality()
                    .equals(other.backImage, backImage)) &&
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
      const DeepCollectionEquality().hash(month) ^
      const DeepCollectionEquality().hash(monthNumber) ^
      const DeepCollectionEquality().hash(year) ^
      const DeepCollectionEquality().hash(cardColor) ^
      const DeepCollectionEquality().hash(frontImage) ^
      const DeepCollectionEquality().hash(backImage) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt);

  @JsonKey(ignore: true)
  @override
  _$MonthDiaryCopyWith<_MonthDiary> get copyWith =>
      __$MonthDiaryCopyWithImpl<_MonthDiary>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MonthDiaryToJson(this);
  }
}

abstract class _MonthDiary implements MonthDiary {
  const factory _MonthDiary(
      {required Month month,
      required int monthNumber,
      required int year,
      CardColor cardColor,
      StorageFile? frontImage,
      StorageFile? backImage,
      @createdAtKey required DateTime createdAt,
      @updatedAtKey required DateTime updatedAt}) = _$_MonthDiary;

  factory _MonthDiary.fromJson(Map<String, dynamic> json) =
      _$_MonthDiary.fromJson;

  @override
  Month get month => throw _privateConstructorUsedError;
  @override
  int get monthNumber => throw _privateConstructorUsedError;
  @override
  int get year => throw _privateConstructorUsedError;
  @override
  CardColor get cardColor => throw _privateConstructorUsedError;
  @override
  StorageFile? get frontImage => throw _privateConstructorUsedError;
  @override
  StorageFile? get backImage => throw _privateConstructorUsedError;
  @override
  @createdAtKey
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  @updatedAtKey
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MonthDiaryCopyWith<_MonthDiary> get copyWith =>
      throw _privateConstructorUsedError;
}
