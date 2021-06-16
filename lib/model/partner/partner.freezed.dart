// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'partner.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Partner _$PartnerFromJson(Map<String, dynamic> json) {
  return _Partner.fromJson(json);
}

/// @nodoc
class _$PartnerTearOff {
  const _$PartnerTearOff();

  _Partner call(
      {required List<String> userIds,
      @anniversaryKey DateTime? anniversary,
      @createdAtKey required DateTime createdAt,
      @updatedAtKey required DateTime updatedAt}) {
    return _Partner(
      userIds: userIds,
      anniversary: anniversary,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Partner fromJson(Map<String, Object> json) {
    return Partner.fromJson(json);
  }
}

/// @nodoc
const $Partner = _$PartnerTearOff();

/// @nodoc
mixin _$Partner {
  List<String> get userIds => throw _privateConstructorUsedError;
  @anniversaryKey
  DateTime? get anniversary => throw _privateConstructorUsedError;
  @createdAtKey
  DateTime get createdAt => throw _privateConstructorUsedError;
  @updatedAtKey
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PartnerCopyWith<Partner> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerCopyWith<$Res> {
  factory $PartnerCopyWith(Partner value, $Res Function(Partner) then) =
      _$PartnerCopyWithImpl<$Res>;
  $Res call(
      {List<String> userIds,
      @anniversaryKey DateTime? anniversary,
      @createdAtKey DateTime createdAt,
      @updatedAtKey DateTime updatedAt});
}

/// @nodoc
class _$PartnerCopyWithImpl<$Res> implements $PartnerCopyWith<$Res> {
  _$PartnerCopyWithImpl(this._value, this._then);

  final Partner _value;
  // ignore: unused_field
  final $Res Function(Partner) _then;

  @override
  $Res call({
    Object? userIds = freezed,
    Object? anniversary = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      userIds: userIds == freezed
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      anniversary: anniversary == freezed
          ? _value.anniversary
          : anniversary // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
abstract class _$PartnerCopyWith<$Res> implements $PartnerCopyWith<$Res> {
  factory _$PartnerCopyWith(_Partner value, $Res Function(_Partner) then) =
      __$PartnerCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<String> userIds,
      @anniversaryKey DateTime? anniversary,
      @createdAtKey DateTime createdAt,
      @updatedAtKey DateTime updatedAt});
}

/// @nodoc
class __$PartnerCopyWithImpl<$Res> extends _$PartnerCopyWithImpl<$Res>
    implements _$PartnerCopyWith<$Res> {
  __$PartnerCopyWithImpl(_Partner _value, $Res Function(_Partner) _then)
      : super(_value, (v) => _then(v as _Partner));

  @override
  _Partner get _value => super._value as _Partner;

  @override
  $Res call({
    Object? userIds = freezed,
    Object? anniversary = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_Partner(
      userIds: userIds == freezed
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      anniversary: anniversary == freezed
          ? _value.anniversary
          : anniversary // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$_Partner implements _Partner {
  const _$_Partner(
      {required this.userIds,
      @anniversaryKey this.anniversary,
      @createdAtKey required this.createdAt,
      @updatedAtKey required this.updatedAt});

  factory _$_Partner.fromJson(Map<String, dynamic> json) =>
      _$_$_PartnerFromJson(json);

  @override
  final List<String> userIds;
  @override
  @anniversaryKey
  final DateTime? anniversary;
  @override
  @createdAtKey
  final DateTime createdAt;
  @override
  @updatedAtKey
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Partner(userIds: $userIds, anniversary: $anniversary, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Partner &&
            (identical(other.userIds, userIds) ||
                const DeepCollectionEquality()
                    .equals(other.userIds, userIds)) &&
            (identical(other.anniversary, anniversary) ||
                const DeepCollectionEquality()
                    .equals(other.anniversary, anniversary)) &&
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
      const DeepCollectionEquality().hash(userIds) ^
      const DeepCollectionEquality().hash(anniversary) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt);

  @JsonKey(ignore: true)
  @override
  _$PartnerCopyWith<_Partner> get copyWith =>
      __$PartnerCopyWithImpl<_Partner>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PartnerToJson(this);
  }
}

abstract class _Partner implements Partner {
  const factory _Partner(
      {required List<String> userIds,
      @anniversaryKey DateTime? anniversary,
      @createdAtKey required DateTime createdAt,
      @updatedAtKey required DateTime updatedAt}) = _$_Partner;

  factory _Partner.fromJson(Map<String, dynamic> json) = _$_Partner.fromJson;

  @override
  List<String> get userIds => throw _privateConstructorUsedError;
  @override
  @anniversaryKey
  DateTime? get anniversary => throw _privateConstructorUsedError;
  @override
  @createdAtKey
  DateTime get createdAt => throw _privateConstructorUsedError;
  @override
  @updatedAtKey
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PartnerCopyWith<_Partner> get copyWith =>
      throw _privateConstructorUsedError;
}
