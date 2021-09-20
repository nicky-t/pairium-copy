import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../state/is_exist_partner_state/is_exist_partner_state_provider.dart';
import '../../state/pair_state/pair_stream_provider.dart';
import '../../state/partner_state/partner_stream.dart';
import '../../state/user_state/user_stream_provider.dart';
import '../../view_model/settings_view_model.dart';
import '../edit_user_profile_screen/edit_user_profile_screen.dart';
import '../full_image_screen/full_image_screen.dart';
import '../partner_info_screen/partner_info_screen.dart';
import '../register_partner_screen.dart/register_partner_screen.dart';

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
    final viewModel = ref.watch(settingsViewModelProvider);

    final userDoc = ref.watch(userStreamProvider).data?.value;
    final user = userDoc?.entity;

    final isExistPartner = ref.watch(isExistPartnerStateProvider);

    final pair =
        ref.watch(pairStreamProvider(user?.pairId ?? '')).data?.value?.entity;

    final partner = ref
        .watch(partnerStreamProvider(pair?.partnerDocumentId ?? ''))
        .data
        ?.value
        ?.entity;

    if (userDoc == null || user == null) {
      return const Center(child: CircularProgressIndicator());
    }

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
                            EditUserProfileScreen.route(userDoc: userDoc),
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
                  onTap: () {
                    if (isExistPartner) {
                      Navigator.push(
                        context,
                        PartnerInfoScreen.route(
                          pair: pair!,
                          partner: partner!,
                        ),
                      );
                    } else {
                      Navigator.push(context, RegisterPartnerScreen.route());
                    }
                  },
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
                    await viewModel.logout();
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
