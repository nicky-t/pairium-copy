import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../components/widgets/buttons/round_border_button.dart';
import '../../constants.dart';
import '../../view_model/welcome_view_model/welcome_view_model_provider.dart';
import '../email_sign_in_screen/email_sign_in_screen.dart';
import 'widgets/log_in_button.dart';

class WelcomeScreen extends HookWidget {
  const WelcomeScreen();

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const WelcomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _viewModel = useProvider(welcomeViewModelProvider);
    final _infoText = useState('');

    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 4,
          left: 36,
          right: 36,
          bottom: 60,
        ),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            colors: [
              theme.backgroundColor.withOpacity(0.3),
              theme.primaryColor.withOpacity(0.3),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kAppName,
                  style: theme.textTheme.headline4!.copyWith(
                    color: theme.textTheme.headline4!.color!
                        .withBlue(60)
                        .withRed(30)
                        .withAlpha(255),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text('仕事先の時間管理ををもっと楽に', style: theme.textTheme.headline5),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'タイムカードの補充はめんどくさくないですか？',
                  style: theme.textTheme.subtitle1,
                ),
                const SizedBox(
                  height: 10,
                ),
                // Text(
                //   '出勤できる日をまとめて店長に送るのはめんどくさくないですか？',
                //   style: theme.textTheme.subtitle1,
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                Text(
                  'このアプリはそんな問題を解決するアプリです！',
                  style: theme.textTheme.subtitle1,
                ),
              ],
            ),
            RoundBorderButton(
              text: '$kAppNameを始める',
              textStyle:
                  theme.textTheme.button!.copyWith(fontWeight: FontWeight.bold),
              width: double.infinity,
              onPressed: () => showBarModalBottomSheet<Widget>(
                context: context,
                barrierColor: Colors.black.withOpacity(0.5),
                backgroundColor: theme.backgroundColor,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: 24,
                      bottom: 60,
                    ),
                    height: 400,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LogInButton(
                          buttonType: Buttons.Email,
                          text: 'Emailでサインイン',
                          onPress: () => Navigator.push(
                            context,
                            EmailSignInScreen.route(),
                          ),
                        ),
                        LogInButton(
                          buttonType: Buttons.GoogleDark,
                          text: 'Googleでサインイン',
                          onPress: () async {
                            await EasyLoading.show(status: 'loading...');
                            _infoText.value = await _viewModel.googleSignIn();
                            await EasyLoading.dismiss();
                            if (_infoText.value != kSuccessCode &&
                                _infoText.value != kCancelCode) {
                              await EasyLoading.showError(
                                '${_infoText.value}',
                                duration: const Duration(seconds: 5),
                              );
                            }
                          },
                        ),
                        LogInButton(
                          buttonType: Buttons.Apple,
                          text: 'Appleでサインイン',
                          onPress: () {
                            // Todo Apple sign in　機能追加
                            //  Apple Developer Programに入らないとできない。
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Column(
                            children: [
                              const Text(
                                '※勝手に投稿することはありません',
                                style: TextStyle(fontSize: 13),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  const Text(
                                    '私は',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  GestureDetector(
                                    // Todo 利用規約を用意する
                                    onTap: () {},
                                    child: Text(
                                      '利用規約',
                                      style: TextStyle(
                                        fontSize: 13,
                                        decoration: TextDecoration.underline,
                                        color: theme.accentColor,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'および',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  GestureDetector(
                                    // Todo プライバシーポリシーを用意する
                                    onTap: () {},
                                    child: Text(
                                      'プライバシーポリシー',
                                      style: TextStyle(
                                        fontSize: 13,
                                        decoration: TextDecoration.underline,
                                        color: theme.accentColor,
                                      ),
                                    ),
                                  ),
                                  const Text(
                                    'に同意して登録します。',
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
