import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/enums/month.dart';
import '../../../model/month_diary/month_diary.dart';
import '../../day_card_list_screen/day_card_list_screen.dart';
import '../screen_state/home_state_provider.dart';
import 'month_card.dart';

class FlipMonthCard extends ConsumerWidget {
  const FlipMonthCard({
    required this.cardKey,
    required this.month,
    required this.openSetting,
    this.monthDiary,
    Key? key,
  }) : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final MonthDiary? monthDiary;
  final Month month;
  final void Function() openSetting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flipCardState = ref.watch(isOnTapFlipStates[month.name]!).state;

    void onTap() {
      ref.read(isOnTapFlipStates[month.name]!).state =
          flipCardState.copyWith(isOnTap: !flipCardState.isOnTap);
    }

    return AnimatedPadding(
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: flipCardState.isSelected
            ? MediaQuery.of(context).size.width / 10
            : MediaQuery.of(context).size.width / 10 + 12,
      ),
      child: FlipCard(
        key: cardKey,
        flipOnTouch: false,
        front: MonthCard(
          toDateCardList: () => Navigator.of(context).push(
            DayCardListScreen.route(month: month),
          ),
          onTap: onTap,
          isSelected: flipCardState.isSelected,
          isOnTap: flipCardState.isOnTap,
          month: month,
          monthImageUrl: monthDiary?.frontImage?.url ?? '',
          openSetting: openSetting,
          cacheImage: flipCardState.frontCacheImageFile,
        ),
        back: MonthCard(
          toDateCardList: () => Navigator.of(context).push(
            DayCardListScreen.route(month: month),
          ),
          onTap: onTap,
          isSelected: flipCardState.isSelected,
          isOnTap: flipCardState.isOnTap,
          month: month,
          monthImageUrl: monthDiary?.backImage?.url ?? '',
          openSetting: openSetting,
          cacheImage: flipCardState.backCacheImageFile,
        ),
      ),
    );
  }
}
