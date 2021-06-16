import 'package:freezed_annotation/freezed_annotation.dart';

enum CardColor {
  @JsonValue('black')
  black,
  @JsonValue('red')
  red,
  @JsonValue('blue')
  blue,
}
