import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../model/enums/month.dart';
import '../screen_state/home_state_provider.dart';

/*
 * ダイアログのアニメーションとbarrierの調整を行っている
 */
class ModalOverlay extends ModalRoute<void> {
  ModalOverlay({
    required this.contents,
    this.isAndroidBackEnable = true,
  }) : super();

  final Widget contents;

  // Androidのバックボタンを有効にするか
  final bool isAndroidBackEnable;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 600);
  @override
  bool get opaque => false;
  @override
  bool get barrierDismissible => false;
  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);
  @override
  String get barrierLabel => '';
  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: Center(
            child: dialogContent(context),
          ),
        ),
      ),
    );
  }

  Widget dialogContent(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future(() => isAndroidBackEnable);
      },
      child: contents,
    );
  }
}

class SelectYearDialog {
  SelectYearDialog(this.context) : super();
  BuildContext context;

  Future<void> showSelectYearPopup({
    required Month selectedMonth,
    required PreloadPageController controller,
  }) async {
    await Navigator.push(
      context,
      ModalOverlay(
        contents: SelectYearPopup(
          selectedMonth: selectedMonth,
          controller: controller,
        ),
      ),
    );
  }
}

class SelectYearPopup extends ConsumerWidget {
  const SelectYearPopup({
    required this.selectedMonth,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final Month selectedMonth;
  final PreloadPageController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final selectedYear = ref.watch(selectedYearStateProvider);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height / 3 * 2,
        width: MediaQuery.of(context).size.width - 32,
        margin: const EdgeInsets.only(bottom: 52),
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Icon(
              Icons.arrow_drop_up,
              color: theme.primaryColor,
              size: 32,
            ),
            const Divider(
              height: 1,
              color: Colors.black38,
            ),
            Flexible(
              child: ScrollablePositionedList.builder(
                initialScrollIndex: 10 - (DateTime.now().year - selectedYear),
                itemCount: 12,
                itemBuilder: (context, index) {
                  final year = DateTime.now().year - 10 + index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            year.toString(),
                            style: theme.textTheme.headline6,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 140,
                          width: MediaQuery.of(context).size.width - 82,
                          child: GridView.builder(
                            itemCount: 12,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(4),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 2,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: year == selectedYear &&
                                            selectedMonth.index == index
                                        ? theme.primaryColor
                                        : theme.backgroundColor,
                                  ),
                                ),
                                onPressed: () async {
                                  ref
                                      .read(selectedYearStateProvider.notifier)
                                      .state = year;
                                  controller.jumpToPage(index);
                                  await Future<void>.delayed(
                                      const Duration(milliseconds: 400));
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  Month.values[index].shortName,
                                  style: theme.textTheme.bodyText2?.copyWith(
                                    color: year == selectedYear &&
                                            selectedMonth.index == index
                                        ? theme.primaryColor
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.black38,
            ),
            Icon(
              Icons.arrow_drop_down,
              color: theme.primaryColor,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}
