import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/provider/navigator_key_provider.dart';
import 'japanese_cupertino_location.dart';
import 'screen/bottom_navigator_screen/bottom_navigator_screen.dart';
import 'screen/error_screen.dart';
import 'screen/register_partner_screen.dart/register_partner_screen.dart';
import 'screen/register_user_profile_screen/register_user_profile_screen.dart';
import 'screen/splash_screen.dart';
import 'screen/welcome_screen/welcome_screen.dart';
import 'state/auth_state/auth_state.dart';
import 'state/auth_state/auth_state_provider.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = ref.watch(navigatorKeyProvider);

    ref.listen<AuthState>(authStateProvider, (authState) {
      switch (authState) {
        case AuthState.loading:
          return;
        case AuthState.noLogin:
          navigatorKey.currentState?.pushAndRemoveUntil(
            WelcomeScreen.route(),
            (route) => false,
          );
          return;
        case AuthState.userProfile:
          navigatorKey.currentState?.pushAndRemoveUntil(
            RegisterUserProfileScreen.route(),
            (route) => false,
          );
          return;
        case AuthState.registerPartner:
          navigatorKey.currentState?.pushAndRemoveUntil(
            RegisterPartnerScreen.route(),
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
    });
    return MaterialApp(
      title: 'pairium',
      navigatorKey: navigatorKey,
      theme: FlexColorScheme.light(
        scheme: FlexScheme.aquaBlue,
        appBarStyle: FlexAppBarStyle.background,
      ).toTheme.copyWith(
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.grey.withOpacity(0.5))),
      darkTheme: FlexColorScheme.dark(
        scheme: FlexScheme.aquaBlue,
        appBarStyle: FlexAppBarStyle.background,
      ).toTheme,
      themeMode: ThemeMode.light,
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
    );
  }
}
