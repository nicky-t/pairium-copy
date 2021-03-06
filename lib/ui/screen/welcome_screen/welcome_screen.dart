import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../components/widgets/buttons/gradient_button.dart';
import '../../components/widgets/glass_container.dart';
import '../log_in_screen/log_in_screen.dart';
import '../sign_in_screen/sign_in_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const WelcomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            top: MediaQuery.of(context).size.height / 1.7,
          ),
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 0.6, 0.7],
              colors: [
                Colors.transparent,
                Colors.white10,
                Colors.white,
              ],
            ),
          ),
          child: GlassContainer(
            width: double.infinity,
            height: double.infinity,
            borderRadius: 24,
            blur: 0,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    kAppName,
                    style: theme.textTheme.headline4?.copyWith(
                      fontFamily: IFonts().kAppTitle,
                      color: theme.textTheme.subtitle1?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '$kAppName???\n??????????????????????????????\n??????????????????????????????????????????',
                    style: theme.textTheme.bodyText2?.copyWith(
                      letterSpacing: 2.4,
                      color: theme.textTheme.caption?.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 16),
                  GradientButton(
                    text: '$kAppName???????????????',
                    onPressed: () =>
                        Navigator.of(context).push(SignInScreen.route()),
                    elevation: 2,
                    isStretch: true,
                  ),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '????????????????????????????????????????????????',
                        style: theme.textTheme.caption,
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).push(LogInScreen.route()),
                        child: const Text(
                          '????????????',
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
      ),
    );
  }
}
