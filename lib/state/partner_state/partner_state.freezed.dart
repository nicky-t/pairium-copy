// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'partner_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$PartnerStateTearOff {
  const _$PartnerStateTearOff();

  _PartnerState call({PartnerDocument? partnerDoc}) {
    return _PartnerState(
      partnerDoc: partnerDoc,
    );
  }
}

/// @nodoc
const $PartnerState = _$PartnerStateTearOff();

/// @nodoc
mixin _$PartnerState {
  PartnerDocument? get partnerDoc => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PartnerStateCopyWith<PartnerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerStateCopyWith<$Res> {
  factory $PartnerStateCopyWith(
          PartnerState value, $Res Function(PartnerState) then) =
      _$PartnerStateCopyWithImpl<$Res>;
  $Res call({PartnerDocument? partnerDoc});
}

/// @nodoc
class _$PartnerStateCopyWithImpl<$Res> implements $PartnerStateCopyWith<$Res> {
  _$PartnerStateCopyWithImpl(this._value, this._then);

  final PartnerState _value;
  // ignore: unused_field
  final $Res Function(PartnerState) _then;

  @override
  $Res call({
    Object? partnerDoc = freezed,
  }) {
    return _then(_value.copyWith(
      partnerDoc: partnerDoc == freezed
          ? _value.partnerDoc
          : partnerDoc // ignore: cast_nullable_to_non_nullable
              as PartnerDocument?,
    ));
  }
}

/// @nodoc
abstract class _$PartnerStateCopyWith<$Res>
    implements $PartnerStateCopyWith<$Res> {
  factory _$PartnerStateCopyWith(
          _PartnerState value, $Res Function(_PartnerState) then) =
      __$PartnerStateCopyWithImpl<$Res>;
  @override
  $Res call({PartnerDocument? partnerDoc});
}

/// @nodoc
class __$PartnerStateCopyWithImpl<$Res> extends _$PartnerStateCopyWithImpl<$Res>
    implements _$PartnerStateCopyWith<$Res> {
  __$PartnerStateCopyWithImpl(
      _PartnerState _value, $Res Function(_PartnerState) _then)
      : super(_value, (v) => _then(v as _PartnerState));

  @override
  _PartnerState get _value => super._value as _PartnerState;

  @override
  $Res call({
    Object? partnerDoc = freezed,
  }) {
    return _then(_PartnerState(
      partnerDoc: partnerDoc == freezed
          ? _value.partnerDoc
          : partnerDoc // ignore: cast_nullable_to_non_nullable
              as PartnerDocument?,
    ));
  }
}

/// @nodoc

class _$_PartnerState implements _PartnerState {
  const _$_PartnerState({this.partnerDoc});

  @override
  final PartnerDocument? partnerDoc;

  @override
  String toString() {
    return 'PartnerState(partnerDoc: $partnerDoc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _PartnerState &&
            (identical(other.partnerDoc, partnerDoc) ||
                const DeepCollectionEquality()
                    .equals(other.partnerDoc, partnerDoc)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(partnerDoc);

  @JsonKey(ignore: true)
  @override
  _$PartnerStateCopyWith<_PartnerState> get copyWith =>
      __$PartnerStateCopyWithImpl<_PartnerState>(this, _$identity);
}

abstract class _PartnerState implements PartnerState {
  const factory _PartnerState({PartnerDocument? partnerDoc}) = _$_PartnerState;

  @override
  PartnerDocument? get partnerDoc => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PartnerStateCopyWith<_PartnerState> get copyWith =>
      throw _privateConstructorUsedError;
}
