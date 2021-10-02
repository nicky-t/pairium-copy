import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/state/auth_state/auth_controller_provider.dart';
import '../../../application/state/partner_state/partner_stream.dart';
import '../../../application/state/user_state/user_controller_provider.dart';
import '../../../application/use_case/fetch_pair_user_data.dart/fetch_pair_user_data.dart';
import '../../../constants.dart';
import '../../../model/enums/request_status.dart';
import '../edit_user_profile_screen/edit_user_profile_screen.dart';
import '../error_screen.dart';
import '../full_image_screen/full_image_screen.dart';
import '../partner_info_screen/partner_info_screen.dart';
import '../register_partner_screen.dart/register_partner_screen.dart';
import '../terms_of_use_screen/terms_of_use_screen.dart';

// TODO 使ってみる
class AsyncContainer<T> extends StatelessWidget {
  const AsyncContainer({
    required this.asyncValue,
    required this.builder,
    Key? key,
  }) : super(key: key);

  final AsyncValue<T> asyncValue;
  final Widget Function(BuildContext, T) builder;

  @override
  Widget build(BuildContext context) {
    return asyncValue.when(
      data: (data) => builder(context, data),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const ErrorScreen(),
    );
  }
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const SettingsScreen(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final authController = ref.watch(authControllerProvider.notifier);
    final fetchPairUserDataUseCase = ref.watch(fetchPairUserDataProvider);

    final userState = ref.watch(userControllerProvider).data?.value;

    final partner = ref.watch(partnerStreamProvider).data?.value?.entity;

    if (userState == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final user = userState.entity;

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (user.mainProfileImage == null)
                      Material(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: theme.disabledColor,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 48,
                          ),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () async {
                          await Navigator.of(context).push(
                            FullImageScreen.route(
                              imageProvider:
                                  NetworkImage(user.mainProfileImage!.url),
                              heroTag: HeroTag.kMainProfile,
                              imageUrl: user.mainProfileImage!.url,
                            ),
                          );
                        },
                        child: Hero(
                          tag: HeroTag.kMainProfile,
                          child: Material(
                            elevation: 12,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(
                                    user.mainProfileImage!.url,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      user.displayName,
                      style: theme.textTheme.subtitle1
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            EditUserProfileScreen.route(userState: userState),
                          ),
                          child: const Text('編集'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Divider(
                  color: theme.disabledColor.withOpacity(0.3),
                  height: 1,
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: Text(
                    'パートナーの設定',
                    style: theme.textTheme.subtitle2
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: theme.scaffoldBackgroundColor,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.people_alt),
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () async {
                    if (partner != null &&
                        partner.requestStatus == RequestStatus.accept) {
                      await EasyLoading.show(status: '');
                      final pair = await fetchPairUserDataUseCase
                          .fetchPairUserData(partner: partner);
                      await EasyLoading.dismiss();
                      await Navigator.push(
                        context,
                        PartnerInfoScreen.route(
                          pair: pair,
                          partner: partner,
                        ),
                      );
                    } else {
                      await Navigator.push(
                          context, RegisterPartnerScreen.route());
                    }
                  },
                ),
                ListTile(
                  title: Text(
                    'このアプリについて',
                    style: theme.textTheme.subtitle2
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: theme.scaffoldBackgroundColor,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.book),
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () =>
                      Navigator.push(context, TermsOfUseScreen.route()),
                ),
                ListTile(
                  title: Text(
                    'ログアウト',
                    style: theme.textTheme.subtitle2
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: theme.scaffoldBackgroundColor,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.logout),
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () async {
                    await authController.logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
