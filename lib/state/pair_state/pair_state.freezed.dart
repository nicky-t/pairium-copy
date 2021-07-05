// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'pair_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PairStateTearOff {
  const _$PairStateTearOff();

  _PairState call({User? pair}) {
    return _PairState(
      pair: pair,
    );
  }
}

/// @nodoc
const $PairState = _$PairStateTearOff();

/// @nodoc
mixin _$PairState {
  User? get pair => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PairStateCopyWith<PairState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairStateCopyWith<$Res> {
  factory $PairStateCopyWith(PairState value, $Res Function(PairState) then) =
      _$PairStateCopyWithImpl<$Res>;
  $Res call({User? pair});

  $UserCopyWith<$Res>? get pair;
}

/// @nodoc
class _$PairStateCopyWithImpl<$Res> implements $PairStateCopyWith<$Res> {
  _$PairStateCopyWithImpl(this._value, this._then);

  final PairState _value;
  // ignore: unused_field
  final $Res Function(PairState) _then;

  @override
  $Res call({
    Object? pair = freezed,
  }) {
    return _then(_value.copyWith(
      pair: pair == freezed
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }

  @override
  $UserCopyWith<$Res>? get pair {
    if (_value.pair == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.pair!, (value) {
      return _then(_value.copyWith(pair: value));
    });
  }
}

/// @nodoc
abstract class _$PairStateCopyWith<$Res> implements $PairStateCopyWith<$Res> {
  factory _$PairStateCopyWith(
          _PairState value, $Res Function(_PairState) then) =
      __$PairStateCopyWithImpl<$Res>;
  @override
  $Res call({User? pair});

  @override
  $UserCopyWith<$Res>? get pair;
}

/// @nodoc
class __$PairStateCopyWithImpl<$Res> extends _$PairStateCopyWithImpl<$Res>
    implements _$PairStateCopyWith<$Res> {
  __$PairStateCopyWithImpl(_PairState _value, $Res Function(_PairState) _then)
      : super(_value, (v) => _then(v as _PairState));

  @override
  _PairState get _value => super._value as _PairState;

  @override
  $Res call({
    Object? pair = freezed,
  }) {
    return _then(_PairState(
      pair: pair == freezed
          ? _value.pair
          : pair // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc

class _$_PairState implements _PairState {
  const _$_PairState({this.pair});

  @override
  final User? pair;

  @override
  String toString() {
    return 'PairState(pair: $pair)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PairState &&
            (identical(other.pair, pair) ||
                const DeepCollectionEquality().equals(other.pair, pair)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(pair);

  @JsonKey(ignore: true)
  @override
  _$PairStateCopyWith<_PairState> get copyWith =>
      __$PairStateCopyWithImpl<_PairState>(this, _$identity);
}

abstract class _PairState implements PairState {
  const factory _PairState({User? pair}) = _$_PairState;

  @override
  User? get pair => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PairStateCopyWith<_PairState> get copyWith =>
      throw _privateConstructorUsedError;
}
