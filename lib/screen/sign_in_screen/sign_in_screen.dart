import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/widgets/buttons/round_border_button.dart';
import '../../constants.dart';
import '../../view_model/sign_in_view_model/sign_in_view_model_provider.dart';
import '../log_in_screen/log_in_screen.dart';

class SignInScreen extends HookWidget {
  const SignInScreen();

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const SignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(signInViewModelProvider);

    final theme = Theme.of(context);

    final _email = useState('');
    final _password = useState('');
    final _emailErrorText = useState<String?>(null);
    final _infoText = useState('');

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        await Future<void>.delayed(const Duration(milliseconds: 300));
        Navigator.pop(context);
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            actions: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('SignIn', style: theme.textTheme.bodyText1),
              ),
            ],
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Image.asset(
                  'assets/signIn.png',
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if (Platform.isAndroid)
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          SocialSignInButton(
                            imagePath: 'assets/google.png',
                            onPressed: () async {
                              await EasyLoading.show(status: 'loading...');
                              _infoText.value = await viewModel.googleSignIn();
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
                          if (Platform.isAndroid)
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          SocialSignInButton(
                            imagePath: 'assets/facebook.png',
                            onPressed: () async {
                              await EasyLoading.show(status: 'loading...');
                              _infoText.value =
                                  await viewModel.facebookSignIn();
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
                          if (Platform.isIOS)
                            SocialLoginButton(
                              imagePath: 'assets/apple.png',
                              // TODO(nicky-t): Apple認証の追加, https://github.com/nicky-t/pairium/issues/2
                              onPressed: () {},
                            ),
                          if (Platform.isAndroid)
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'or  Eメールで登録',
                        style: theme.textTheme.caption,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: 'email',
                            labelStyle: theme.textTheme.caption,
                            fillColor: theme.backgroundColor,
                            icon: const Icon(Icons.email),
                            errorText:
                                _emailErrorText.value == null ? null : ''),
                        onChanged: (String value) {
                          _email.value = value;
                        },
                      ),
                      const SizedBox(height: 1),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'password',
                          labelStyle: theme.textTheme.caption,
                          fillColor: theme.backgroundColor,
                          hintText: '６文字以上入力してください',
                          hintStyle: theme.textTheme.caption,
                          icon: const Icon(Icons.vpn_key),
                          errorText: _emailErrorText.value,
                          errorMaxLines: 3,
                        ),
                        obscureText: true,
                        onChanged: (String value) {
                          _password.value = value;
                        },
                      ),
                      SizedBox(height: _emailErrorText.value == null ? 28 : 8),
                      SizedBox(
                        width: double.infinity,
                        child: RoundBorderButton(
                          text: '新規登録する',
                          backgroundColor: theme.accentColor,
                          textStyle: theme.textTheme.button?.copyWith(
                            color: theme.backgroundColor,
                            fontWeight: FontWeight.w600,
                          ),
                          borderColor: theme.accentColor,
                          elevation: 2,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          onPressed: () async {
                            await EasyLoading.show(status: 'loading...');
                            final text = await viewModel.signIn(
                              email: _email.value,
                              password: _password.value,
                            );
                            if (text != kSuccessCode) {
                              _emailErrorText.value = text;
                            }
                            await EasyLoading.dismiss();
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              'すでに登録済みの方は',
                              style: theme.textTheme.caption,
                            ),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.push(context, LogInScreen.route()),
                            child: const Text(
                              'ログイン',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
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
    );
  }
}

class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    required this.imagePath,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String imagePath;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            side: BorderSide(
              color: Theme.of(context).disabledColor.withOpacity(0.2),
              width: 1,
              style: BorderStyle.solid,
            ),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Image.asset(imagePath),
          ),
        ),
      ),
    );
  }
}
