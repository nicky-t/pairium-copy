import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'application/state/auth_state/auth_controller_provider.dart';
import 'application/state/auth_state/auth_state.dart';
import 'japanese_cupertino_location.dart';
import 'ui/components/provider/navigator_key_provider.dart';
import 'ui/screen/bottom_navigator_screen/bottom_navigator_screen.dart';
import 'ui/screen/error_screen.dart';
import 'ui/screen/register_partner_screen.dart/register_partner_screen.dart';
import 'ui/screen/register_user_profile_screen/register_user_profile_screen.dart';
import 'ui/screen/splash_screen.dart';
import 'ui/screen/welcome_screen/welcome_screen.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = ref.watch(navigatorKeyProvider);

    ref.listen<AuthState>(authControllerProvider, (authState) {
      switch (authState.status) {
        case AuthStatus.loading:
          return;
        case AuthStatus.noLogin:
          navigatorKey.currentState?.pushAndRemoveUntil(
            WelcomeScreen.route(),
            (route) => false,
          );
          return;
        case AuthStatus.userProfile:
          navigatorKey.currentState?.pushAndRemoveUntil(
            RegisterUserProfileScreen.route(),
            (route) => false,
          );
          return;
        case AuthStatus.registerPartner:
          navigatorKey.currentState?.pushAndRemoveUntil(
            RegisterPartnerScreen.route(),
            (route) => false,
          );
          return;
        case AuthStatus.login:
          navigatorKey.currentState?.pushAndRemoveUntil(
            BottomNavigatorScreen.route(),
            (route) => false,
          );
          return;
        case AuthStatus.error:
          navigatorKey.currentState?.pushAndRemoveUntil(
            ErrorScreen.route(),
            (route) => false,
          );
          return;
      }
    });
    return MaterialApp(
      title: 'pairium',
      navigatorKey: navigatorKey,
      theme: FlexColorScheme.light(
        scheme: FlexScheme.aquaBlue,
        appBarStyle: FlexAppBarStyle.background,
      ).toTheme,
      darkTheme: FlexColorScheme.dark(
        scheme: FlexScheme.aquaBlue,
        appBarStyle: FlexAppBarStyle.background,
      ).toTheme,
      themeMode: ThemeMode.light,
      builder: EasyLoading.init(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
      ],
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
    );
  }
}
