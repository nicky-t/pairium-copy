import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../flavor.dart';
import '../../state/bottom_navigator/bottom_navigator.dart';
import '../../state/bottom_navigator/bottom_navigator_provider.dart';
import 'bottom_bar_view.dart';

class BottomNavigatorScreen extends ConsumerStatefulWidget {
  const BottomNavigatorScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const BottomNavigatorScreen(),
    );
  }

  @override
  _BottomNavigatorScreenState createState() => _BottomNavigatorScreenState();
}

class _BottomNavigatorScreenState extends ConsumerState<BottomNavigatorScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController?.dispose();
      animationController = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentScreenState = ref.watch(currentBottomNavigatorStateProvider);
    final flavor = ref.watch(flavorProvider);

    return Scaffold(
      body: Stack(
        children: [
          currentScreenState.screen,
          _BottomBar(
            flavor: flavor,
          ),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.flavor,
    Key? key,
  }) : super(key: key);

  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          addClick: () {},
          changeIndex: (int index) {
            // if (index == 0 || index == 2) {
            //   animationController?.reverse().then<dynamic>((data) {
            //     if (!mounted) {
            //       return;
            //     }
            //     setState(() {
            //       tabBody =
            //        MyDiaryScreen(animationController: animationController);
            //     });
            //   });
            // } else if (index == 1 || index == 3) {
            //   animationController?.reverse().then<dynamic>((data) {
            //     if (!mounted) {
            //       return;
            //     }
            //     setState(() {
            //       tabBody =
            //         TrainingScreen(animationController: animationController);
            //     });
            //   });
            // }
          },
        ),
      ],
    );
  }
}
