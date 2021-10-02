import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'app.dart';
import 'flavor.dart';
import 'ui/components/widgets/loading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await runZonedGuarded<Future<void>>(() async {
    FlutterError.onError = (FlutterErrorDetails details) async {
      FlutterError.dumpErrorToConsole(details);
      if (kDebugMode || Flavor().current == FlavorType.stg) {
        await sendError(details.exceptionAsString());
      }
      // exit(1);
    };
    runApp(
      ProviderScope(
        observers: [
          _ProviderObserver(),
        ],
        child: const App(),
      ),
    );
    configLoading();
  }, (dynamic error, StackTrace stackTrace) async {
    if (kDebugMode || Flavor().current == FlavorType.stg) {
      await sendError(error.toString());
    }
    // exit(1);
  });
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
    ..textColor = Colors.white
    ..userInteractions = false
    ..dismissOnTap = false;
}

@immutable
class _ProviderObserver implements ProviderObserver {
  _ProviderObserver();

  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1, // number of method calls to be displayed
      lineLength: 80, // width of the output
    ),
  );

  @override
  void didAddProvider(
    ProviderBase<dynamic> provider,
    Object? value,
    ProviderContainer container,
  ) {
    // logger.d('provider: $provider,\nvalue: $value');
  }

  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    // logger.d('provider: $provider');
  }

  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    // logger.d('provider: $provider,\nnewValue: $newValue');
  }
}

Future<void> sendError(String text) async {
  final url = Uri.parse('https://slack.com/api/chat.postMessage?channel');

  final json = jsonEncode({
    'channel': '#clash-report',
    'text': text,
  });
  await http.post(
    url,
    headers: {
      'Authorization':
          'Bearer xoxb-1623665784882-2539165348132-54txyVHPdk4ulcidmgd65cVn',
      'Content-Type': 'application/json',
    },
    body: json,
  );
  print(text);
}
