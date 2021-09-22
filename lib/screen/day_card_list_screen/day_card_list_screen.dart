import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../model/enums/month.dart';
import '../../model/enums/week_day.dart';
import '../../state/day_diary_state/day_diary_state_provider.dart';
import '../../view_model/day_card_list_view_model.dart';
import '../day_diary_screen.dart/day_diary_screen.dart';
import 'widget/day_card.dart';

class DayCardListScreen extends ConsumerStatefulWidget {
  const DayCardListScreen({
    required this.year,
    required this.month,
    Key? key,
  }) : super(key: key);

  final Month month;
  final int year;

  static Route<void> route({
    required Month month,
    required int year,
  }) {
    return MaterialPageRoute<dynamic>(
      builder: (_) {
        return DayCardListScreen(
          month: month,
          year: year,
        );
      },
    );
  }

  @override
  _DayCardListScreenState createState() => _DayCardListScreenState();
}

class _DayCardListScreenState extends ConsumerState<DayCardListScreen> {
  bool isReverse = false;

  @override
  void initState() {
    ref
        .read(dayCardListViewModelProvider)
        .init(year: widget.year, month: widget.month.number);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final dayDiaryState = ref.watch(dayDiaryStateProvider);
    final dayDiaries =
        dayDiaryState.dayDiaryDocs.where((doc) => doc?.entity != null).toList();

    return Scaffold(
      backgroundColor: IColors.kScaffoldColor,
      appBar: AppBar(
        backgroundColor: IColors.kScaffoldColor,
        title: Text(
          widget.year.toString(),
          style: theme.textTheme.headline6?.copyWith(
            fontFamily: IFonts().kCabin,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isReverse = !isReverse;
              });
            },
            icon: const Icon(Icons.swap_vert),
          )
        ],
      ),
      body: dayDiaryState.isFetching
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          final dayDiary = isReverse
                              ? dayDiaries[dayDiaries.length - 1 - index]!
                              : dayDiaries[index]!;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: DayCard(
                              day: dayDiary.entity.day,
                              title: dayDiary.entity.title,
                              weekDay: getWeekDayFromNumber(
                                  dayDiary.entity.date.weekday),
                              dayImageUrl: dayDiary.entity.mainImage.url,
                              onPressed: () async {
                                ref
                                    .read(
                                        selectedDayDiaryStateProvider.notifier)
                                    .state = dayDiary;
                                await Navigator.of(context).push(
                                  DayDiaryScreen.route(),
                                );
                              },
                            ),
                          );
                        },
                        itemCount: dayDiaries.length),
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
    );
  }
}
