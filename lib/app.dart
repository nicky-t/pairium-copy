import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/provider/navigator_key_provider.dart';
import 'japanese_cupertino_location.dart';
import 'screen/bottom_navigator_screen/bottom_navigator_screen.dart';
import 'screen/error_screen.dart';
import 'screen/splash_screen.dart';
import 'screen/welcome_screen/welcome_screen.dart';
import 'state/auth_state/auth_state.dart';
import 'state/auth_state/auth_state_provider.dart';
import 'theme.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final navigatorKey = useProvider(navigatorKeyProvider);

    return ProviderListener<AuthState>(
      provider: authStateProvider,
      onChange: (context, authState) {
        switch (authState) {
          case AuthState.loading:
            return;
          case AuthState.noLogin:
            navigatorKey.currentState?.pushAndRemoveUntil(
              WelcomeScreen.route(),
              (route) => false,
            );
            return;
          case AuthState.login:
            navigatorKey.currentState?.pushAndRemoveUntil(
              BottomNavigatorScreen.route(),
              (route) => false,
            );
            return;
          case AuthState.error:
            navigatorKey.currentState?.pushAndRemoveUntil(
              ErrorScreen.route(),
              (route) => false,
            );
            return;
        }
      },
      child: MaterialApp(
        title: 'pairium',
        navigatorKey: navigatorKey,
        theme: FlexColorScheme.light(
          colors: customFlexScheme.light,
          // scaffoldBackground: const Color(0xffEDF2F3),
          // background: const Color(0xffffffff),
        ).toTheme,
        darkTheme: FlexColorScheme.dark(colors: customFlexScheme.light.toDark())
            .toTheme,
        // themeMode: ThemeMode.dark,
        builder: EasyLoading.init(),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          JapaneseCupertinoLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ja'),
        ],
        locale: const Locale('ja', 'JP'),
        home: const SplashScreen(),
      ),
    );
  }
}
