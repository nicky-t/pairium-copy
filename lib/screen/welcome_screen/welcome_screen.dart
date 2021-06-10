import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/widgets/buttons/gradient_button.dart';
import '../../constants.dart';
import '../log_in_screen/log_in_screen.dart';
import '../sign_in_screen/sign_in_screen.dart';

class WelcomeScreen extends HookWidget {
  const WelcomeScreen();

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const WelcomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    print(theme.primaryColorLight);
    return Scaffold(
      body: Container(
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
            image: AssetImage('assets/welcome.jpg'),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 1.6,
          ),
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.6, 0.7],
              colors: [
                Colors.transparent,
                Colors.white24,
                Colors.white,
              ],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 16,
            ),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.4],
                colors: [
                  Colors.white54,
                  Colors.white,
                ],
              ),
              color: theme.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  kAppName,
                  style: GoogleFonts.lobster().copyWith(
                    fontSize: 40,
                    color: theme.textTheme.headline4!.color!
                        .withBlue(60)
                        .withRed(30)
                        .withAlpha(255),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'pairumは\nあなたとパートナーが\n写真を通して繋がる\nアプリです',
                  style: theme.textTheme.caption?.copyWith(
                    letterSpacing: 2.4,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                GradientButton(
                  text: '$kAppNameを始める',
                  onPress: () =>
                      Navigator.of(context).push(SignInScreen.route()),
                  isStretch: true,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        'すでにアカウントをお持ちですか？',
                        style: theme.textTheme.caption,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).push(LogInScreen.route()),
                      child: const Text(
                        'ログイン',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
