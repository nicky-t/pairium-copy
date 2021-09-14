import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'components/widgets/loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(const ProviderScope(child: App()));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorWidget = const Loading()
    ..indicatorColor = Colors.red
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..indicatorSize = 160
    ..maskColor = Colors.black54
    ..boxShadow = const []
    ..backgroundColor = Colors.transparent
    ..textColor = Colors.transparent
    ..userInteractions = false
    ..dismissOnTap = false;
}
