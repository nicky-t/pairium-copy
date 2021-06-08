import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

const myFlexSchemeColor = FlexSchemeColor(
  primary: Color(0xff33b9a7),
  primaryVariant: Color(0xff01906b),
  secondary: Color(0xffEA7733),
  secondaryVariant: Color(0xFFBD6208),
);

final FlexSchemeData customFlexScheme = FlexSchemeData(
  name: 'pairium light green',
  description: 'green theme created from custom defined colors.',
  light: myFlexSchemeColor,
  dark: myFlexSchemeColor.toDark(),
);
