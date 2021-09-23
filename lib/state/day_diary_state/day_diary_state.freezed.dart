// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'day_diary_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DayDiaryStateTearOff {
  const _$DayDiaryStateTearOff();

  _DayDiaryState call(
      {List<DayDiaryDocument?> dayDiaryDocs = const <DayDiaryDocument>[],
      bool isFetching = false}) {
    return _DayDiaryState(
      dayDiaryDocs: dayDiaryDocs,
      isFetching: isFetching,
    );
  }
}

/// @nodoc
const $DayDiaryState = _$DayDiaryStateTearOff();

/// @nodoc
mixin _$DayDiaryState {
  List<DayDiaryDocument?> get dayDiaryDocs =>
      throw _privateConstructorUsedError;
  bool get isFetching => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DayDiaryStateCopyWith<DayDiaryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayDiaryStateCopyWith<$Res> {
  factory $DayDiaryStateCopyWith(
          DayDiaryState value, $Res Function(DayDiaryState) then) =
      _$DayDiaryStateCopyWithImpl<$Res>;
  $Res call({List<DayDiaryDocument?> dayDiaryDocs, bool isFetching});
}

/// @nodoc
class _$DayDiaryStateCopyWithImpl<$Res>
    implements $DayDiaryStateCopyWith<$Res> {
  _$DayDiaryStateCopyWithImpl(this._value, this._then);

  final DayDiaryState _value;
  // ignore: unused_field
  final $Res Function(DayDiaryState) _then;

  @override
  $Res call({
    Object? dayDiaryDocs = freezed,
    Object? isFetching = freezed,
  }) {
    return _then(_value.copyWith(
      dayDiaryDocs: dayDiaryDocs == freezed
          ? _value.dayDiaryDocs
          : dayDiaryDocs // ignore: cast_nullable_to_non_nullable
              as List<DayDiaryDocument?>,
      isFetching: isFetching == freezed
          ? _value.isFetching
          : isFetching // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$DayDiaryStateCopyWith<$Res>
    implements $DayDiaryStateCopyWith<$Res> {
  factory _$DayDiaryStateCopyWith(
          _DayDiaryState value, $Res Function(_DayDiaryState) then) =
      __$DayDiaryStateCopyWithImpl<$Res>;
  @override
  $Res call({List<DayDiaryDocument?> dayDiaryDocs, bool isFetching});
}

/// @nodoc
class __$DayDiaryStateCopyWithImpl<$Res>
    extends _$DayDiaryStateCopyWithImpl<$Res>
    implements _$DayDiaryStateCopyWith<$Res> {
  __$DayDiaryStateCopyWithImpl(
      _DayDiaryState _value, $Res Function(_DayDiaryState) _then)
      : super(_value, (v) => _then(v as _DayDiaryState));

  @override
  _DayDiaryState get _value => super._value as _DayDiaryState;

  @override
  $Res call({
    Object? dayDiaryDocs = freezed,
    Object? isFetching = freezed,
  }) {
    return _then(_DayDiaryState(
      dayDiaryDocs: dayDiaryDocs == freezed
          ? _value.dayDiaryDocs
          : dayDiaryDocs // ignore: cast_nullable_to_non_nullable
              as List<DayDiaryDocument?>,
      isFetching: isFetching == freezed
          ? _value.isFetching
          : isFetching // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_DayDiaryState implements _DayDiaryState {
  const _$_DayDiaryState(
      {this.dayDiaryDocs = const <DayDiaryDocument>[],
      this.isFetching = false});

  @JsonKey(defaultValue: const <DayDiaryDocument>[])
  @override
  final List<DayDiaryDocument?> dayDiaryDocs;
  @JsonKey(defaultValue: false)
  @override
  final bool isFetching;

  @override
  String toString() {
    return 'DayDiaryState(dayDiaryDocs: $dayDiaryDocs, isFetching: $isFetching)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DayDiaryState &&
            (identical(other.dayDiaryDocs, dayDiaryDocs) ||
                const DeepCollectionEquality()
                    .equals(other.dayDiaryDocs, dayDiaryDocs)) &&
            (identical(other.isFetching, isFetching) ||
                const DeepCollectionEquality()
                    .equals(other.isFetching, isFetching)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(dayDiaryDocs) ^
      const DeepCollectionEquality().hash(isFetching);

  @JsonKey(ignore: true)
  @override
  _$DayDiaryStateCopyWith<_DayDiaryState> get copyWith =>
      __$DayDiaryStateCopyWithImpl<_DayDiaryState>(this, _$identity);
}

abstract class _DayDiaryState implements DayDiaryState {
  const factory _DayDiaryState(
      {List<DayDiaryDocument?> dayDiaryDocs,
      bool isFetching}) = _$_DayDiaryState;

  @override
  List<DayDiaryDocument?> get dayDiaryDocs =>
      throw _privateConstructorUsedError;
  @override
  bool get isFetching => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DayDiaryStateCopyWith<_DayDiaryState> get copyWith =>
      throw _privateConstructorUsedError;
}
