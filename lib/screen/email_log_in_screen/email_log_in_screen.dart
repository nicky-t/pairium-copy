import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/widgets/buttons/round_border_button.dart';
import '../../view_model/email_log_in_view_model/email_log_in_view_model_provider.dart';

class EmailLogInScreen extends HookWidget {
  const EmailLogInScreen();

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const EmailLogInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _viewModel = useProvider(emailLogInViewModelProvider);

    final theme = Theme.of(context);

    final _email = useState('');
    final _password = useState('');
    final _infoText = useState('');

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        await Future<void>.delayed(const Duration(milliseconds: 300));
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white54,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 52, bottom: 10, right: 10, left: 10),
                child: Text(
                  'おかえりなさい',
                  style: theme.textTheme.headline6,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 24, left: 24),
                child: Text(
                  'メールアドレスとパスワードを入力してログインしてください。',
                  style: theme.textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'メールアドレス'),
                      onChanged: (String value) {
                        _email.value = value;
                      },
                    ),
                    // パスワード入力
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'パスワード'),
                      obscureText: true,
                      onChanged: (String value) {
                        _password.value = value;
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      // メッセージ表示
                      child: Text(_infoText.value),
                    ),
                    Wrap(
                      children: [
                        Text(
                          'すでに登録済みの方はこちら',
                          style: theme.textTheme.bodyText2,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            '新規登録',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: theme.accentColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SizedBox(
                      width: double.infinity,
                      // ユーザー登録ボタン
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
                          // Todo パスワード再設定機能
                          _infoText.value = await _viewModel.logIn(
                              email: _email.value, password: _password.value);
                          await EasyLoading.dismiss();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
