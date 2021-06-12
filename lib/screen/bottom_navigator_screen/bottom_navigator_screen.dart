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

    BottomNavigationBarItem createTab(
      BuildContext context,
      BottomNavigatorType type,
    ) {
      return BottomNavigationBarItem(
        icon: GestureDetector(
          onLongPress: flavor.current == FlavorType.dev
              ? () => showBarModalBottomSheet<Widget>(
                    context: context,
                    barrierColor: Colors.black.withOpacity(0.5),
                    backgroundColor: Theme.of(context).backgroundColor,
                    builder: (context) => Container(),
                  )
              : null,
          child: Icon(
            type.iconData,
            size: 26,
          ),
        ),
        label: '',
      );
    }

    return Scaffold(
      body: currentScreenState.screen,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).backgroundColor,
        currentIndex: currentScreenState.index,
        onTap: screenTypeNotifier.setCurrentBottomNavigator,
        items: BottomNavigatorType.values
            .map((type) => createTab(context, type))
            .toList(),
        selectedItemColor: Theme.of(context).textTheme.bodyText1?.color,
        selectedIconTheme: Theme.of(context)
            .iconTheme
            .copyWith(color: Theme.of(context).textTheme.bodyText1?.color),
        unselectedIconTheme: Theme.of(context)
            .iconTheme
            .copyWith(color: Theme.of(context).disabledColor),
      ),
    );
  }
}
