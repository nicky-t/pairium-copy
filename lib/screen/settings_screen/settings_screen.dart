import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/user_state/user_stream_provider.dart';
import '../../view_model/settings_view_model/settings_view_model_provider.dart';
import '../edit_user_profile_screen/edit_user_profile_screen.dart';
import '../error_screen.dart';

class SettingsScreen extends HookWidget {
  const SettingsScreen();

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const SettingsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewModel = useProvider(settingsViewModelProvider);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: useProvider(userStreamProvider).when(
        data: (userDoc) {
          if (userDoc == null) return const ErrorScreen();
          final user = userDoc.entity;

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: ListView(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (user.mainProfileImage == null)
                        Card(
                          elevation: 4,
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
                        Card(
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
                                image: NetworkImage(
                                  user.mainProfileImage!.url,
                                ),
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.displayName,
                            style: theme.textTheme.subtitle1
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
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
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (_, __) => const ErrorScreen(),
      ),
    );
  }
}
