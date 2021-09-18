import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/widgets/buttons/gradient_button.dart';
import '../../constants.dart';
import '../../view_model/log_in_view_model.dart';
import '../sign_in_screen/sign_in_screen.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const LogInScreen(),
    );
  }

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  String _email = '';
  String _password = '';
  bool _isObscure = true;
  String? _errorText;
  String _infoText = '';

  @override
  Widget build(BuildContext context) {
    final _viewModel = ref.watch(logInViewModelProvider);

    final theme = Theme.of(context);

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
            backgroundColor: theme.backgroundColor,
            actions: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Login',
                  style: theme.textTheme.subtitle1?.copyWith(
                      fontFamily: IFonts().kCabin, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Image.asset(
                  'assets/login.png',
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
                          SocialLoginButton(
                            imagePath: 'assets/google.png',
                            onPressed: () async {
                              await EasyLoading.show(status: '');
                              final result = await _viewModel.googleLogin();
                              setState(() {
                                _infoText = result;
                              });
                              await EasyLoading.dismiss();
                              if (_infoText != kSuccessCode &&
                                  _infoText != kCancelCode) {
                                await EasyLoading.showError(
                                  _infoText,
                                  dismissOnTap: true,
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
                          SocialLoginButton(
                            imagePath: 'assets/facebook.png',
                            onPressed: () async {
                              await EasyLoading.show(status: '');
                              final result = await _viewModel.facebookLogin();
                              setState(() {
                                _infoText = result;
                              });
                              await EasyLoading.dismiss();
                              if (_infoText != kSuccessCode &&
                                  _infoText != kCancelCode) {
                                await EasyLoading.showError(
                                  _infoText,
                                  dismissOnTap: true,
                                  duration: const Duration(seconds: 5),
                                );
                              }
                            },
                          ),
                          if (Platform.isIOS)
                            SocialLoginButton(
                              imagePath: 'assets/apple.png',
                              onPressed: () async {
                                await EasyLoading.show(status: '');
                                final result = await _viewModel.appleSignIn();
                                print(result);
                                await EasyLoading.dismiss();
                                if (mounted) {
                                  setState(() {
                                    _infoText = result;
                                  });
                                }
                                if (_infoText != kSuccessCode &&
                                    _infoText != kCancelCode) {
                                  await EasyLoading.showError(
                                    _infoText,
                                    dismissOnTap: true,
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
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'or  Eメールログイン',
                        style: theme.textTheme.caption,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'email',
                          labelStyle: theme.textTheme.caption,
                          fillColor: theme.backgroundColor,
                          icon: const Icon(Icons.email),
                          errorText: _errorText == null ? null : '',
                        ),
                        onChanged: (String value) {
                          setState(() {
                            _email = value;
                          });
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
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          errorText: _errorText,
                          errorMaxLines: 3,
                        ),
                        obscureText: _isObscure,
                        onChanged: (String value) {
                          _password = value;
                        },
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            // TODO(nicky-t): パスワード確認機能, https://github.com/nicky-t/pairium/issues/1
                          },
                          child: Text(
                            'パスワードを忘れてしまった',
                            style: theme.textTheme.caption?.copyWith(
                              decoration: TextDecoration.underline,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: _errorText == null ? 8 : 0),
                      GradientButton(
                        text: 'ログインする',
                        onPressed: () async {
                          await EasyLoading.show(status: '');
                          final text = await _viewModel.logIn(
                              email: _email, password: _password);
                          if (text != kSuccessCode) {
                            setState(() {
                              _errorText = text;
                            });
                          }
                          await EasyLoading.dismiss();
                        },
                        elevation: 2,
                        radius: 8,
                        isStretch: true,
                        textStyle: theme.textTheme.button?.copyWith(
                          color: theme.backgroundColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            'アカウントをお持ちでない方は',
                            style: theme.textTheme.caption,
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.push(context, SignInScreen.route()),
                            child: const Text(
                              '新規登録',
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

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
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
