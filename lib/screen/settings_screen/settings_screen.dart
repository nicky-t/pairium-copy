import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/enums/request_status.dart';
import '../../state/pair_state/pair_stream_provider.dart';
import '../../state/partner_state/partner_stream.dart';
import '../../state/user_state/user_stream_provider.dart';
import '../../view_model/settings_view_model.dart';
import '../edit_user_profile_screen/edit_user_profile_screen.dart';
import '../partner_info_screen/partner_info_screen.dart';
import '../register_partner_screen.dart/register_partner_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen();

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const SettingsScreen(),
    );
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final viewModel = watch(settingsViewModelProvider);

    final userDoc = watch(userStreamProvider).when(
      data: (userDoc) => userDoc,
      loading: () => null,
      error: (_, __) => null,
    );
    final user = userDoc?.entity;

    final pair = watch(pairStreamProvider(user?.pairId ?? '')).when(
      data: (pair) => pair?.entity,
      loading: () => null,
      error: (_, __) => null,
    );

    final partner =
        watch(partnerStreamProvider(pair?.partnerDocumentId ?? '')).when(
      data: (data) => data?.entity,
      loading: () => null,
      error: (_, __) => null,
    );

    if (userDoc == null || user == null) {
      return const CircularProgressIndicator();
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
                      Material(
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
                    if (user.pairId != null &&
                        pair != null &&
                        partner != null &&
                        user.partnerRequestStatus == RequestStatus.accept) {
                      Navigator.push(
                          context,
                          PartnerInfoScreen.route(
                              pair: pair, partner: partner));
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
