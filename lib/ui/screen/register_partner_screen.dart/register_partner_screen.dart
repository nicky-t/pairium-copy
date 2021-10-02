import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../application/state/auth_state/auth_controller_provider.dart';
import '../../../application/state/auth_state/auth_state.dart';
import '../../../application/state/bottom_navigator/bottom_navigator_provider.dart';
import '../../../application/state/partner_state/partner_controller_provider.dart';
import '../../../application/state/partner_state/partner_state.dart';
import '../../../application/state/partner_state/partner_stream.dart';
import '../../../application/state/user_state/user_controller_provider.dart';
import '../../../application/state/user_state/user_state.dart';
import '../../../application/use_case/register_partner/register_partner.dart';
import '../../../constants.dart';
import '../../../model/enums/request_status.dart';
import '../../../utility/custom_exception.dart';
import '../../components/provider/navigator_key_provider.dart';
import '../../components/widgets/buttons/gradient_button.dart';
import '../bottom_navigator_screen/bottom_navigator_screen.dart';

class RegisterPartnerScreen extends ConsumerStatefulWidget {
  const RegisterPartnerScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const RegisterPartnerScreen(),
    );
  }

  @override
  ConsumerState<RegisterPartnerScreen> createState() =>
      _RegisterPartnerScreenState();
}

class _RegisterPartnerScreenState extends ConsumerState<RegisterPartnerScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final authController = ref.read(authControllerProvider.notifier);
    final userController = ref.read(userControllerProvider.notifier);
    final registerPartnerUseCase = ref.read(registerPartnerUseCaseProvider);

    final partnerState = ref.watch(partnerStreamProvider).data?.value;
    final partner = partnerState?.entity;

    final navigatorKey = ref.watch(navigatorKeyProvider);
    final userState = ref.watch(userControllerProvider).data?.value;
    final uid = ref.watch(authControllerProvider).authUser?.uid;

    if (uid == null) throw const CustomException();

    ref.listen<PartnerState?>(partnerControllerProvider, (partnerState) async {
      if (partnerState == null) return;
      final partner = partnerState.entity;

      if (partner.requestStatus == RequestStatus.reject &&
          partner.submitRequestUser == uid) {
        await Alert(
          context: context,
          title: '申請が拒否されました',
          buttons: [],
        ).show();
      }
      if (partner.requestStatus == RequestStatus.accept) {
        ref
            .read(currentBottomNavigatorControllerProvider.notifier)
            .setCurrentBottomNavigator(0);
        await navigatorKey.currentState?.pushAndRemoveUntil(
          BottomNavigatorScreen.route(),
          (route) => false,
        );
      }
    });

    if (userState == null) return const CircularProgressIndicator();

    return WillPopScope(
      onWillPop: () async {
        if (partner?.requestStatus == RequestStatus.waiting) return true;
        Navigator.pop(context);
        return true;
      },
      child: Stack(
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
                          '自分のID: ${userState.entity.shareId}',
                          style: theme.textTheme.subtitle1
                              ?.copyWith(color: theme.textTheme.caption?.color),
                        ),
                      ),
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _textController,
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
                          if (text.length > 6 && text.length < 10) {
                            setState(() {});
                          }
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
                        onPressed: _textController.text.length == 8
                            ? () async {
                                await EasyLoading.show(status: '');
                                final requestStatus =
                                    await registerPartnerUseCase.requestPartner(
                                  pairShareId: _textController.text,
                                );

                                _textController.clear();
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
                      Visibility(
                        visible: !userState.entity.isFinishedOnboarding,
                        child: Center(
                          child: Text(
                            'or',
                            style: theme.textTheme.caption,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Visibility(
                        visible: !userState.entity.isFinishedOnboarding,
                        child: GradientButton(
                          text: 'まずは１人で始める',
                          isStretch: true,
                          onPressed: () async {
                            await EasyLoading.show(status: '');
                            await userController.startAppOne();
                            authController.setAuthState(AuthStatus.login);

                            await EasyLoading.dismiss();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: partner?.requestStatus == RequestStatus.waiting,
            child: Container(
              color: theme.disabledColor.withOpacity(0.5),
            ),
          ),
          if (partnerState != null &&
              partner?.submitRequestUser == uid &&
              partner?.requestStatus == RequestStatus.waiting)
            _WaitingRequestDialog(
              cancelRequest: () => registerPartnerUseCase.cancelRequest(
                partnerState: partnerState,
              ),
            ),
          if (partner?.receiveRequestUser == uid &&
              partnerState != null &&
              partner?.requestStatus == RequestStatus.waiting)
            FutureBuilder<UserState?>(
                future: partner?.submitRequestUser == null
                    ? null
                    : registerPartnerUseCase.fetchPairUserData(
                        id: partner!.submitRequestUser!,
                      ),
                builder: (context, pairState) {
                  if (pairState.data?.entity == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final pair = pairState.data?.entity;
                  return _RequestedDialog(
                    userDisplayName: userState.entity.displayName,
                    pairDisplayName: pair?.displayName,
                    acceptPartner: ({bool? isSelectedMySelfData}) =>
                        registerPartnerUseCase.acceptPartner(
                      partnerState: partnerState,
                      userState: userState,
                      isSelectedMySelfData: isSelectedMySelfData,
                    ),
                    rejectPartner: () => registerPartnerUseCase.rejectPartner(
                      partnerState: partnerState,
                    ),
                    isTwoStarted: userState.entity.isFinishedOnboarding &&
                        (pair?.isFinishedOnboarding ?? false),
                  );
                }),
        ],
      ),
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
  final Future<void> Function({bool? isSelectedMySelfData}) acceptPartner;

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
                        await widget.acceptPartner(isSelectedMySelfData: true);
                      },
                      text: widget.userDisplayName ?? '',
                    ),
                    GradientButton(
                      onPressed: () async {
                        await widget.acceptPartner(isSelectedMySelfData: false);
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
