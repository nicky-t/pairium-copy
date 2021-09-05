import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kAppName = 'pairium';
const kSuccessCode = 'Success!!';
const kCancelCode = 'Cancel';
const kErrorCode = 'Error';

class IColors {
  static const Color kBlack = Color(0xff121c2c);
  static const Color kPrimary = Color(0xff35a0cb);
  static const Color kPrimarySecondary = Color(0xff89d1c8);
  static const Color kScaffoldColor = Color(0xFFF3F4F7);
}

class IFonts {
  String? kCabin = GoogleFonts.cabin().fontFamily;
  String? kAppTitle = GoogleFonts.lobster().fontFamily;
  String? kYomogi = 'Yomogi';
}

class HeroTag {
  static const String kMonthDiary = 'monthDiary';
  static const String kDayDiary = 'dayDiary';
  static const String kMainProfile = 'mainProfile';
}

const colorList = <Color>[
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
];
