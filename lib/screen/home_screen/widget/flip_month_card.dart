import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../../../model/enums/month.dart';
import '../../../model/month_diary/month_diary.dart';
import '../../day_card_list_screen/day_card_list_screen.dart';
import 'month_card.dart';

class FlipMonthCard extends StatelessWidget {
  const FlipMonthCard({
    required this.cardKey,
    required this.month,
    required this.selectedMonth,
    required this.isOnTap,
    required this.onTap,
    required this.showBottomSheet,
    this.monthDiary,
    Key? key,
  }) : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final MonthDiary? monthDiary;
  final Month month;
  final Month selectedMonth;
  final bool isOnTap;
  final void Function() onTap;
  final void Function() showBottomSheet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 40,
      ),
      child: FlipCard(
        key: cardKey,
        flipOnTouch: false,
        front: MonthCard(
          toDateCardList: () => Navigator.of(context).push(
            DayCardListScreen.route(month: month),
          ),
          onTap: onTap,
          isOnTap: isOnTap,
          month: month,
          selectedMonth: selectedMonth,
          monthImageUrl: monthDiary?.frontImage?.url ?? '',
          openSetting: showBottomSheet,
        ),
        back: MonthCard(
          toDateCardList: () => Navigator.of(context).push(
            DayCardListScreen.route(month: month),
          ),
          onTap: onTap,
          isOnTap: isOnTap,
          month: month,
          selectedMonth: selectedMonth,
          monthImageUrl: monthDiary?.backImage?.url ?? '',
          openSetting: showBottomSheet,
        ),
      ),
    );
  }
}
