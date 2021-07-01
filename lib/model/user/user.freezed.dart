// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {required String displayName,
      @birthdayKey required DateTime birthday,
      required Gender gender,
      bool isFinishedOnboarding = false,
      StorageFile? mainProfileImage,
      String? pairId,
      String? partnerDocumentId,
      @createdAtKey required DateTime createdAt,
      @updatedAtKey required DateTime updatedAt}) {
    return _User(
      displayName: displayName,
      birthday: birthday,
      gender: gender,
      isFinishedOnboarding: isFinishedOnboarding,
      mainProfileImage: mainProfileImage,
      pairId: pairId,
      partnerDocumentId: partnerDocumentId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  User fromJson(Map<String, Object> json) {
    return User.fromJson(json);
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  String get displayName => throw _privateConstructorUsedError;
  @birthdayKey
  DateTime get birthday => throw _privateConstructorUsedError;
  Gender get gender => throw _privateConstructorUsedError;
  bool get isFinishedOnboarding => throw _privateConstructorUsedError;
  StorageFile? get mainProfileImage => throw _privateConstructorUsedError;
  String? get pairId => throw _privateConstructorUsedError;
  String? get partnerDocumentId => throw _privateConstructorUsedError;
  @createdAtKey
  DateTime get createdAt => throw _privateConstructorUsedError;
  @updatedAtKey
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {String displayName,
      @birthdayKey DateTime birthday,
      Gender gender,
      bool isFinishedOnboarding,
      StorageFile? mainProfileImage,
      String? pairId,
      String? partnerDocumentId,
      @createdAtKey DateTime createdAt,
      @updatedAtKey DateTime updatedAt});

  $StorageFileCopyWith<$Res>? get mainProfileImage;
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? displayName = freezed,
    Object? birthday = freezed,
    Object? gender = freezed,
    Object? isFinishedOnboarding = freezed,
    Object? mainProfileImage = freezed,
    Object? pairId = freezed,
    Object? partnerDocumentId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: birthday == freezed
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      isFinishedOnboarding: isFinishedOnboarding == freezed
          ? _value.isFinishedOnboarding
          : isFinishedOnboarding // ignore: cast_nullable_to_non_nullable
              as bool,
      mainProfileImage: mainProfileImage == freezed
          ? _value.mainProfileImage
          : mainProfileImage // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
      pairId: pairId == freezed
          ? _value.pairId
          : pairId // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerDocumentId: partnerDocumentId == freezed
          ? _value.partnerDocumentId
          : partnerDocumentId // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $StorageFileCopyWith<$Res>? get mainProfileImage {
    if (_value.mainProfileImage == null) {
      return null;
    }

    return $StorageFileCopyWith<$Res>(_value.mainProfileImage!, (value) {
      return _then(_value.copyWith(mainProfileImage: value));
    });
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {String displayName,
      @birthdayKey DateTime birthday,
      Gender gender,
      bool isFinishedOnboarding,
      StorageFile? mainProfileImage,
      String? pairId,
      String? partnerDocumentId,
      @createdAtKey DateTime createdAt,
      @updatedAtKey DateTime updatedAt});

  @override
  $StorageFileCopyWith<$Res>? get mainProfileImage;
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
    Object? displayName = freezed,
    Object? birthday = freezed,
    Object? gender = freezed,
    Object? isFinishedOnboarding = freezed,
    Object? mainProfileImage = freezed,
    Object? pairId = freezed,
    Object? partnerDocumentId = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_User(
      displayName: displayName == freezed
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      birthday: birthday == freezed
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime,
      gender: gender == freezed
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      isFinishedOnboarding: isFinishedOnboarding == freezed
          ? _value.isFinishedOnboarding
          : isFinishedOnboarding // ignore: cast_nullable_to_non_nullable
              as bool,
      mainProfileImage: mainProfileImage == freezed
          ? _value.mainProfileImage
          : mainProfileImage // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
      pairId: pairId == freezed
          ? _value.pairId
          : pairId // ignore: cast_nullable_to_non_nullable
              as String?,
      partnerDocumentId: partnerDocumentId == freezed
          ? _value.partnerDocumentId
          : partnerDocumentId // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$_User implements _User {
  const _$_User(
      {required this.displayName,
      @birthdayKey required this.birthday,
      required this.gender,
      this.isFinishedOnboarding = false,
      this.mainProfileImage,
      this.pairId,
      this.partnerDocumentId,
      @createdAtKey required this.createdAt,
      @updatedAtKey required this.updatedAt});

  factory _$_User.fromJson(Map<String, dynamic> json) =>
      _$_$_UserFromJson(json);

  @override
  final String displayName;
  @override
  @birthdayKey
  final DateTime birthday;
  @override
  final Gender gender;
  @JsonKey(defaultValue: false)
  @override
  final bool isFinishedOnboarding;
  @override
  final StorageFile? mainProfileImage;
  @override
  final String? pairId;
  @override
  final String? partnerDocumentId;
  @override
  @createdAtKey
  final DateTime createdAt;
  @override
  @updatedAtKey
  final DateTime updatedAt;

  @override
  String toString() {
    return 'User(displayName: $displayName, birthday: $birthday, gender: $gender, isFinishedOnboarding: $isFinishedOnboarding, mainProfileImage: $mainProfileImage, pairId: $pairId, partnerDocumentId: $partnerDocumentId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _User &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)) &&
            (identical(other.birthday, birthday) ||
                const DeepCollectionEquality()
                    .equals(other.birthday, birthday)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.isFinishedOnboarding, isFinishedOnboarding) ||
                const DeepCollectionEquality().equals(
                    other.isFinishedOnboarding, isFinishedOnboarding)) &&
            (identical(other.mainProfileImage, mainProfileImage) ||
                const DeepCollectionEquality()
                    .equals(other.mainProfileImage, mainProfileImage)) &&
            (identical(other.pairId, pairId) ||
                const DeepCollectionEquality().equals(other.pairId, pairId)) &&
            (identical(other.partnerDocumentId, partnerDocumentId) ||
                const DeepCollectionEquality()
                    .equals(other.partnerDocumentId, partnerDocumentId)) &&
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
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(birthday) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(isFinishedOnboarding) ^
      const DeepCollectionEquality().hash(mainProfileImage) ^
      const DeepCollectionEquality().hash(pairId) ^
      const DeepCollectionEquality().hash(partnerDocumentId) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt);

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UserToJson(this);
  }
}

abstract class _User implements User {
  const factory _User(
      {required String displayName,
      @birthdayKey required DateTime birthday,
      required Gender gender,
      bool isFinishedOnboarding,
      StorageFile? mainProfileImage,
      String? pairId,
      String? partnerDocumentId,
      @createdAtKey required DateTime createdAt,
      @updatedAtKey required DateTime updatedAt}) = _$_User;

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  String get displayName => throw _privateConstructorUsedError;
  @override
  @birthdayKey
  DateTime get birthday => throw _privateConstructorUsedError;
  @override
  Gender get gender => throw _privateConstructorUsedError;
  @override
  bool get isFinishedOnboarding => throw _privateConstructorUsedError;
  @override
  StorageFile? get mainProfileImage => throw _privateConstructorUsedError;
  @override
  String? get pairId => throw _privateConstructorUsedError;
  @override
  String? get partnerDocumentId => throw _privateConstructorUsedError;
  @override
  @createdAtKey
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  @updatedAtKey
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}
