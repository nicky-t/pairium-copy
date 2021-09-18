import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../components/provider/navigator_key_provider.dart';
import '../../components/widgets/buttons/gradient_button.dart';
import '../../constants.dart';
import '../../model/enums/request_status.dart';
import '../../state/pair_state/pair_stream_provider.dart';
import '../../state/user_state/user_state.dart';
import '../../state/user_state/user_state_provider.dart';
import '../../state/user_state/user_stream_provider.dart';
import '../../view_model/register_partner_view_model.dart';
import '../bottom_navigator_screen/bottom_navigator_screen.dart';

final _textProvider = StateProvider((ref) => '');

class RegisterPartnerScreen extends ConsumerWidget {
  const RegisterPartnerScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const RegisterPartnerScreen(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = ref.watch(navigatorKeyProvider);
    final theme = Theme.of(context);
    final viewModel = ref.read(registerPartnerViewModelProvider);
    final _pairId = ref.watch(_textProvider).state;

    final user = ref.watch(userStreamProvider).data?.value?.entity;
    final pair =
        ref.watch(pairStreamProvider(user?.pairId ?? '')).data?.value?.entity;

    ref.listen<UserState>(userStateProvider, (userState) async {
      final user = userState.user;
      if (user == null) return;

      if (user.partnerRequestStatus == RequestStatus.reject) {
        await Alert(context: context, title: '申請が拒否されました', buttons: []).show();
      }
      if (user.isFinishedOnboarding &&
          user.partnerDocumentId != null &&
          user.partnerRequestStatus == RequestStatus.accept) {
        await navigatorKey.currentState?.pushAndRemoveUntil(
          BottomNavigatorScreen.route(),
          (route) => false,
        );
      }
    });

    if (user == null) return const CircularProgressIndicator();
    return Stack(
      children: [
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('パートナーの設定'),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      'assets/couple.png',
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    Center(
                      child: SelectableText(
                        '自分のID: ${user.shareId}',
                        style: theme.textTheme.subtitle1
                            ?.copyWith(color: theme.textTheme.caption?.color),
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: theme.primaryColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        labelText: 'パートナーのID...',
                      ),
                      onChanged: (text) {
                        ref.read(_textProvider).state = text;
                      },
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'パートナーのどちらかがIDを入力してください',
                        style: theme.textTheme.caption,
                      ),
                    ),
                    const SizedBox(height: 24),
                    GradientButton(
                      text: 'パートナーに申請を送る',
                      isStretch: true,
                      onPressed: _pairId.length == 8
                          ? () async {
                              await EasyLoading.show(status: '');
                              final requestStatus = await viewModel
                                  .requestPartner(pairShareId: _pairId);

                              ref.read(_textProvider).state = '';
                              await EasyLoading.dismiss();
                              if (requestStatus == kErrorCode) {
                                await EasyLoading.showError(
                                  '申請に失敗しました\n'
                                  'IDが合っているかもう一度ご確認ください。',
                                  dismissOnTap: true,
                                  duration: const Duration(
                                    seconds: 3,
                                  ),
                                );
                              }
                            }
                          : null,
                    ),
                    const SizedBox(height: 24),
                    if (!user.isFinishedOnboarding)
                      Center(
                        child: Text(
                          'or',
                          style: theme.textTheme.caption,
                        ),
                      ),
                    const SizedBox(height: 24),
                    if (!user.isFinishedOnboarding)
                      GradientButton(
                        text: 'まずは１人で始める',
                        isStretch: true,
                        onPressed: () async {
                          await EasyLoading.show(status: '');
                          await viewModel.startAppOne();
                          await EasyLoading.dismiss();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (user.partnerRequestStatus == RequestStatus.waiting ||
            user.partnerRequestStatus == RequestStatus.requested)
          Container(
            color: theme.disabledColor.withOpacity(0.5),
          ),
        if (user.partnerRequestStatus == RequestStatus.waiting)
          _WaitingRequestDialog(cancelRequest: viewModel.cancelRequest),
        if (user.partnerRequestStatus == RequestStatus.requested)
          _RequestedDialog(
            userDisplayName: user.displayName,
            pairDisplayName: pair?.displayName,
            acceptPartner: viewModel.acceptPartner,
            rejectPartner: viewModel.rejectPartner,
            isTwoStarted: user.isFinishedOnboarding &&
                (pair?.isFinishedOnboarding ?? false),
          ),
      ],
    );
  }
}

class _WaitingRequestDialog extends StatelessWidget {
  const _WaitingRequestDialog({
    required this.cancelRequest,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() cancelRequest;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (Rect bounds) => LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.secondaryVariant.withGreen(240),
          ],
        ).createShader(bounds),
        child: const Icon(
          Icons.info_outline,
          size: 72,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '申請承認待ちです',
            style: theme.textTheme.headline6?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'パートナーが申請を承認するまでお待ち下さい。',
            style: theme.textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: theme.disabledColor,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 32,
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
            onPressed: () async {
              await cancelRequest();
            },
            icon: const Icon(Icons.close),
            label: const Text('申請を取り消す'),
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}

class _RequestedDialog extends StatefulWidget {
  const _RequestedDialog({
    required this.userDisplayName,
    required this.pairDisplayName,
    required this.rejectPartner,
    required this.acceptPartner,
    required this.isTwoStarted,
    Key? key,
  }) : super(key: key);

  final String? userDisplayName;
  final String? pairDisplayName;
  final bool isTwoStarted;
  final Future<void> Function() rejectPartner;
  final Future<void> Function({bool? isMe}) acceptPartner;

  @override
  __RequestedDialogState createState() => __RequestedDialogState();
}

class __RequestedDialogState extends State<_RequestedDialog> {
  bool isSelectScreen = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (Rect bounds) => LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.secondaryVariant.withGreen(240),
          ],
        ).createShader(bounds),
        child: const Icon(
          Icons.info_outline,
          size: 72,
        ),
      ),
      content: isSelectScreen
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'どちらもアプリを開始しています',
                  style: theme.textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.userDisplayName ?? ''}さんと'
                  '${widget.pairDisplayName ?? ''}さんどちらの写真を共有アカウントとして使用しますか？',
                  style: theme.textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GradientButton(
                      onPressed: () async {
                        await widget.acceptPartner(isMe: true);
                      },
                      text: widget.userDisplayName ?? '',
                    ),
                    GradientButton(
                      onPressed: () async {
                        await widget.acceptPartner(isMe: false);
                      },
                      text: widget.pairDisplayName ?? '',
                    ),
                  ],
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'パートナー申請',
                  style: theme.textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  '${widget.pairDisplayName ?? ''}'
                  'さんからパートナー申請が届いています。',
                  style: theme.textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: theme.disabledColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 32,
                        ),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await widget.rejectPartner();
                      },
                      child: Text(
                        '拒否',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(color: Theme.of(context).cardColor),
                      ),
                    ),
                    GradientButton(
                      onPressed: () async {
                        if (widget.isTwoStarted) {
                          setState(() {
                            isSelectScreen = true;
                          });
                        } else {
                          await widget.acceptPartner();
                        }
                      },
                      text: '承認',
                    ),
                  ],
                ),
              ],
            ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}
