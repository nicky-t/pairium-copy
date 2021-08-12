import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../model/enums/month.dart';
import '../screen_state/home_state_provider.dart';

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
        decoration: BoxDecoration(
          color: theme.backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Column(
          children: [
            Icon(
              Icons.arrow_drop_up,
              color: theme.primaryColor,
              size: 32,
            ),
            Flexible(
              child: ScrollablePositionedList.builder(
                initialScrollIndex: 10 - (DateTime.now().year - selectedYear),
                itemCount: 12,
                itemBuilder: (context, index) {
                  final year = DateTime.now().year - 10 + index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
                          height: 150,
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
                                onPressed: () {
                                  ref
                                      .read(selectedYearStateProvider.notifier)
                                      .state = year;
                                  Navigator.pop(context);
                                  controller.jumpToPage(index);
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
