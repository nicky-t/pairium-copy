import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/widgets/buttons/round_border_button.dart';
import '../../constants.dart';
import '../../view_model/log_in_view_model/log_in_view_model_provider.dart';

class LogInScreen extends HookWidget {
  const LogInScreen();

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const LogInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _viewModel = useProvider(logInViewModelProvider);

    final theme = Theme.of(context);

    final _email = useState('');
    final _password = useState('');
    final _errorText = useState<String?>(null);

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
                child: Text('Login', style: theme.textTheme.bodyText1),
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
                          SocialLoginButton(
                            imagePath: 'assets/google.png',
                            onPressed: () {},
                          ),
                          SocialLoginButton(
                            imagePath: 'assets/facebook.png',
                            onPressed: () {},
                          ),
                          SocialLoginButton(
                            imagePath: 'assets/apple.png',
                            onPressed: () {},
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
                          errorText: _errorText.value == null ? null : '',
                        ),
                        onChanged: (String value) {
                          _email.value = value;
                        },
                      ),
                      const SizedBox(height: 8),
                      // TODO(nicky-t): パスワード確認機能, https://github.com/nicky-t/pairium/issues/1
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'password',
                          labelStyle: theme.textTheme.caption,
                          fillColor: theme.backgroundColor,
                          hintText: '６文字以上入力してください',
                          hintStyle: theme.textTheme.caption,
                          icon: const Icon(Icons.vpn_key),
                          errorText: _errorText.value,
                          errorMaxLines: 3,
                        ),
                        obscureText: true,
                        onChanged: (String value) {
                          _password.value = value;
                        },
                      ),
                      SizedBox(height: _errorText.value == null ? 28 : 8),
                      SizedBox(
                        width: double.infinity,
                        child: RoundBorderButton(
                          text: 'ログインする',
                          backgroundColor: theme.accentColor,
                          textStyle: theme.textTheme.button?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          borderColor: theme.accentColor,
                          elevation: 2,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          onPressed: () async {
                            await EasyLoading.show(status: 'loading...');
                            final text = await _viewModel.logIn(
                                email: _email.value, password: _password.value);
                            if (text != kSuccessCode) _errorText.value = text;
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
                              'アカウントをお持ちでない方は',
                              style: theme.textTheme.caption,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
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