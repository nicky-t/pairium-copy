import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: App()));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 80.0
    ..radius = 10.0
    ..lineWidth = 100.0
    ..backgroundColor = Colors.white
    ..indicatorColor = IColors.kPrimarySecondary
    ..textColor = Colors.black
    ..maskColor = Colors.blue
    ..userInteractions = true
    ..dismissOnTap = false;
}
