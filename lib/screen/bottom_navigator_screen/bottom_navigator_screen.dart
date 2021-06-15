import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../flavor.dart';
import '../../state/bottom_navigator/bottom_navigator.dart';
import '../../state/bottom_navigator/bottom_navigator_provider.dart';

class BottomNavigatorScreen extends HookWidget {
  const BottomNavigatorScreen();

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const BottomNavigatorScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentScreenState = useProvider(currentBottomNavigatorStateProvider);
    final screenTypeNotifier =
        useProvider(currentBottomNavigatorStateProvider.notifier);
    final flavor = useProvider(flavorProvider);

    final theme = Theme.of(context);

    TabItem<dynamic> createTab(
      BuildContext context,
      BottomNavigatorType type,
    ) {
      return TabItem<dynamic>(
        icon: type.iconData,
        title: type.label,
      );
    }

    return Scaffold(
      body: currentScreenState.screen,
      bottomNavigationBar: GestureDetector(
        onLongPress: flavor.current == FlavorType.dev
            ? () => showBarModalBottomSheet<Widget>(
                  context: context,
                  barrierColor: Colors.black.withOpacity(0.5),
                  backgroundColor: theme.backgroundColor,
                  builder: (context) => Container(),
                )
            : null,
        child: ConvexAppBar(
          elevation: 1,
          style: TabStyle.fixedCircle,
          color: theme.textTheme.bodyText1?.color,
          backgroundColor: theme.backgroundColor,
          activeColor: theme.primaryColor,
          disableDefaultTabController: false,
          items: BottomNavigatorType.values
              .map((type) => createTab(context, type))
              .toList(),
          onTap: screenTypeNotifier.setCurrentBottomNavigator,
        ),
      ),
    );
  }
}
