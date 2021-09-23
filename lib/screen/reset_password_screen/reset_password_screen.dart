import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/widgets/buttons/gradient_button.dart';
import '../../constants.dart';
import '../../view_model/reset_password_view_model.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const ResetPasswordScreen(),
    );
  }

  @override
  ConsumerState<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final TextEditingController _emailTextController = TextEditingController();

  String? _errorText;

  @override
  Widget build(BuildContext context) {
    final _viewModel = ref.watch(resetPasswordViewModel);

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
                  'reset password',
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
                const SizedBox(height: 20),
                Image.asset(
                  'assets/reset-password.png',
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        'パスワード再設定メールの送信',
                        style: theme.textTheme.subtitle1
                            ?.copyWith(color: theme.textTheme.headline1?.color),
                      ),
                      const SizedBox(height: 28),
                      TextFormField(
                        controller: _emailTextController,
                        decoration: InputDecoration(
                          labelText: 'email',
                          labelStyle: theme.textTheme.caption,
                          fillColor: theme.backgroundColor,
                          icon: const Icon(Icons.email),
                          errorText: _errorText,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(height: _errorText == null ? 8 : 0),
                      GradientButton(
                        text: 'メールを送信',
                        onPressed: () async {
                          await EasyLoading.show(status: '');
                          final text = await _viewModel.resetPassword(
                              email: _emailTextController.text);
                          if (text == kSuccessCode) {
                            setState(() {
                              _errorText = null;
                            });
                          } else {
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
