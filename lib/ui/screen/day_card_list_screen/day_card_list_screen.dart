import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../application/state/diary_state/diary_state.dart';
import '../../../application/state/diary_state/diary_state_provider.dart';
import '../../../constants.dart';
import '../../../model/enums/month.dart';
import '../../../model/enums/week_day.dart';
import '../diary_screen.dart/diary_screen.dart';
import '../error_screen.dart';
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
  late final DiaryStateParam diaryStateParam;

  @override
  void initState() {
    diaryStateParam = DiaryStateParam(
      year: widget.year,
      month: widget.month.number,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final asyncDiaryState = ref.watch(dayDiariesControllerProvider(
      diaryStateParam,
    ));

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
      body: asyncDiaryState.when(
          data: (diaryState) {
            final dayDiaries = diaryState.diaryDocs;

            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          final diary = isReverse
                              ? dayDiaries[dayDiaries.length - 1 - index]
                              : dayDiaries[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: DayCard(
                              day: diary.entity.day,
                              title: diary.entity.title,
                              weekDay: getWeekDayFromNumber(
                                diary.entity.date.weekday,
                              ),
                              dayImageUrl: diary.entity.mainImage.url,
                              onPressed: () async {
                                await Navigator.of(context).push(
                                  DiaryScreen.route(date: diary.entity.date),
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
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const ErrorScreen()),
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
