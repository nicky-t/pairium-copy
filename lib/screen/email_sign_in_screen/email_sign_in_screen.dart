import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/widgets/buttons/round_border_button.dart';
import '../../view_model/email_sign_in_view_model/email_sign_in_view_model_provider.dart';
import '../email_log_in_screen/email_log_in_screen.dart';

class EmailSignInScreen extends HookWidget {
  const EmailSignInScreen();

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const EmailSignInScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(emailSignInViewModelProvider);

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
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 52, bottom: 10),
                child: Text(
                  'メールアドレスとパスワードを登録',
                  style: theme.textTheme.headline6,
                ),
              ),
              Text(
                'パスワードは６文字以上で登録してください。',
                style: theme.textTheme.subtitle2,
              ),
              const SizedBox(
                height: 68,
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
                          onTap: () =>
                              Navigator.push(context, EmailLogInScreen.route()),
                          child: Text(
                            'ログイン',
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
                          // Todo パスワード再設定機能
                          _infoText.value = await viewModel.signIn(
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
