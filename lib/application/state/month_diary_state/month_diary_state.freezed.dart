// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'month_diary_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MonthDiaryStateTearOff {
  const _$MonthDiaryStateTearOff();

  _MonthDiaryState call(
      {List<MonthDiaryDocument?> monthDiaryDocs =
          const <MonthDiaryDocument>[]}) {
    return _MonthDiaryState(
      monthDiaryDocs: monthDiaryDocs,
    );
  }
}

/// @nodoc
const $MonthDiaryState = _$MonthDiaryStateTearOff();

/// @nodoc
mixin _$MonthDiaryState {
  List<MonthDiaryDocument?> get monthDiaryDocs =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MonthDiaryStateCopyWith<MonthDiaryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthDiaryStateCopyWith<$Res> {
  factory $MonthDiaryStateCopyWith(
          MonthDiaryState value, $Res Function(MonthDiaryState) then) =
      _$MonthDiaryStateCopyWithImpl<$Res>;
  $Res call({List<MonthDiaryDocument?> monthDiaryDocs});
}

/// @nodoc
class _$MonthDiaryStateCopyWithImpl<$Res>
    implements $MonthDiaryStateCopyWith<$Res> {
  _$MonthDiaryStateCopyWithImpl(this._value, this._then);

  final MonthDiaryState _value;
  // ignore: unused_field
  final $Res Function(MonthDiaryState) _then;

  @override
  $Res call({
    Object? monthDiaryDocs = freezed,
  }) {
    return _then(_value.copyWith(
      monthDiaryDocs: monthDiaryDocs == freezed
          ? _value.monthDiaryDocs
          : monthDiaryDocs // ignore: cast_nullable_to_non_nullable
              as List<MonthDiaryDocument?>,
    ));
  }
}

/// @nodoc
abstract class _$MonthDiaryStateCopyWith<$Res>
    implements $MonthDiaryStateCopyWith<$Res> {
  factory _$MonthDiaryStateCopyWith(
          _MonthDiaryState value, $Res Function(_MonthDiaryState) then) =
      __$MonthDiaryStateCopyWithImpl<$Res>;
  @override
  $Res call({List<MonthDiaryDocument?> monthDiaryDocs});
}

/// @nodoc
class __$MonthDiaryStateCopyWithImpl<$Res>
    extends _$MonthDiaryStateCopyWithImpl<$Res>
    implements _$MonthDiaryStateCopyWith<$Res> {
  __$MonthDiaryStateCopyWithImpl(
      _MonthDiaryState _value, $Res Function(_MonthDiaryState) _then)
      : super(_value, (v) => _then(v as _MonthDiaryState));

  @override
  _MonthDiaryState get _value => super._value as _MonthDiaryState;

  @override
  $Res call({
    Object? monthDiaryDocs = freezed,
  }) {
    return _then(_MonthDiaryState(
      monthDiaryDocs: monthDiaryDocs == freezed
          ? _value.monthDiaryDocs
          : monthDiaryDocs // ignore: cast_nullable_to_non_nullable
              as List<MonthDiaryDocument?>,
    ));
  }
}

/// @nodoc

class _$_MonthDiaryState implements _MonthDiaryState {
  const _$_MonthDiaryState(
      {this.monthDiaryDocs = const <MonthDiaryDocument>[]});

  @JsonKey(defaultValue: const <MonthDiaryDocument>[])
  @override
  final List<MonthDiaryDocument?> monthDiaryDocs;

  @override
  String toString() {
    return 'MonthDiaryState(monthDiaryDocs: $monthDiaryDocs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MonthDiaryState &&
            (identical(other.monthDiaryDocs, monthDiaryDocs) ||
                const DeepCollectionEquality()
                    .equals(other.monthDiaryDocs, monthDiaryDocs)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(monthDiaryDocs);

  @JsonKey(ignore: true)
  @override
  _$MonthDiaryStateCopyWith<_MonthDiaryState> get copyWith =>
      __$MonthDiaryStateCopyWithImpl<_MonthDiaryState>(this, _$identity);
}

abstract class _MonthDiaryState implements MonthDiaryState {
  const factory _MonthDiaryState({List<MonthDiaryDocument?> monthDiaryDocs}) =
      _$_MonthDiaryState;

  @override
  List<MonthDiaryDocument?> get monthDiaryDocs =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$MonthDiaryStateCopyWith<_MonthDiaryState> get copyWith =>
      throw _privateConstructorUsedError;
}
