// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'diary_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DiaryStateTearOff {
  const _$DiaryStateTearOff();

  _DiaryState call({List<DiaryDocument> diaryDocs = const <DiaryDocument>[]}) {
    return _DiaryState(
      diaryDocs: diaryDocs,
    );
  }
}

/// @nodoc
const $DiaryState = _$DiaryStateTearOff();

/// @nodoc
mixin _$DiaryState {
  List<DiaryDocument> get diaryDocs => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DiaryStateCopyWith<DiaryState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryStateCopyWith<$Res> {
  factory $DiaryStateCopyWith(
          DiaryState value, $Res Function(DiaryState) then) =
      _$DiaryStateCopyWithImpl<$Res>;
  $Res call({List<DiaryDocument> diaryDocs});
}

/// @nodoc
class _$DiaryStateCopyWithImpl<$Res> implements $DiaryStateCopyWith<$Res> {
  _$DiaryStateCopyWithImpl(this._value, this._then);

  final DiaryState _value;
  // ignore: unused_field
  final $Res Function(DiaryState) _then;

  @override
  $Res call({
    Object? diaryDocs = freezed,
  }) {
    return _then(_value.copyWith(
      diaryDocs: diaryDocs == freezed
          ? _value.diaryDocs
          : diaryDocs // ignore: cast_nullable_to_non_nullable
              as List<DiaryDocument>,
    ));
  }
}

/// @nodoc
abstract class _$DiaryStateCopyWith<$Res> implements $DiaryStateCopyWith<$Res> {
  factory _$DiaryStateCopyWith(
          _DiaryState value, $Res Function(_DiaryState) then) =
      __$DiaryStateCopyWithImpl<$Res>;
  @override
  $Res call({List<DiaryDocument> diaryDocs});
}

/// @nodoc
class __$DiaryStateCopyWithImpl<$Res> extends _$DiaryStateCopyWithImpl<$Res>
    implements _$DiaryStateCopyWith<$Res> {
  __$DiaryStateCopyWithImpl(
      _DiaryState _value, $Res Function(_DiaryState) _then)
      : super(_value, (v) => _then(v as _DiaryState));

  @override
  _DiaryState get _value => super._value as _DiaryState;

  @override
  $Res call({
    Object? diaryDocs = freezed,
  }) {
    return _then(_DiaryState(
      diaryDocs: diaryDocs == freezed
          ? _value.diaryDocs
          : diaryDocs // ignore: cast_nullable_to_non_nullable
              as List<DiaryDocument>,
    ));
  }
}

/// @nodoc

class _$_DiaryState implements _DiaryState {
  const _$_DiaryState({this.diaryDocs = const <DiaryDocument>[]});

  @JsonKey(defaultValue: const <DiaryDocument>[])
  @override
  final List<DiaryDocument> diaryDocs;

  @override
  String toString() {
    return 'DiaryState(diaryDocs: $diaryDocs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DiaryState &&
            (identical(other.diaryDocs, diaryDocs) ||
                const DeepCollectionEquality()
                    .equals(other.diaryDocs, diaryDocs)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(diaryDocs);

  @JsonKey(ignore: true)
  @override
  _$DiaryStateCopyWith<_DiaryState> get copyWith =>
      __$DiaryStateCopyWithImpl<_DiaryState>(this, _$identity);
}

abstract class _DiaryState implements DiaryState {
  const factory _DiaryState({List<DiaryDocument> diaryDocs}) = _$_DiaryState;

  @override
  List<DiaryDocument> get diaryDocs => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DiaryStateCopyWith<_DiaryState> get copyWith =>
      throw _privateConstructorUsedError;
}
