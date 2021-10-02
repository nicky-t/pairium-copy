import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../../../../model/entity/month_diary/month_diary.dart';
import '../../../../model/enums/month.dart';
import '../../../../model/enums/month_card_color.dart';
import 'month_card.dart';

class FlipMonthCard extends StatelessWidget {
  const FlipMonthCard({
    required this.cardKey,
    required this.month,
    required this.openSetting,
    required this.onTap,
    required this.isSelected,
    required this.isOnTap,
    required this.frontCacheImageFile,
    required this.backCacheImageFile,
    required this.toDayCardList,
    this.monthDiary,
    Key? key,
  }) : super(key: key);

  final GlobalKey<FlipCardState> cardKey;
  final MonthDiary? monthDiary;
  final Month month;
  final VoidCallback openSetting;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isOnTap;
  final File? frontCacheImageFile;
  final File? backCacheImageFile;
  final VoidCallback toDayCardList;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: isSelected
            ? MediaQuery.of(context).size.width / 10
            : MediaQuery.of(context).size.width / 10 + 12,
      ),
      child: FlipCard(
        key: cardKey,
        flipOnTouch: false,
        front: MonthCard(
          toDateCardList: toDayCardList,
          onTap: onTap,
          isSelected: isSelected,
          isOnTap: isOnTap && isSelected,
          month: month,
          monthImageUrl: monthDiary?.frontImage?.url ?? '',
          openSetting: openSetting,
          cacheImage: frontCacheImageFile,
          backgroundColor: monthDiary == null
              ? MonthCardColor.white
              : monthDiary!.backgroundColor,
          textColor:
              monthDiary == null ? MonthCardColor.grey : monthDiary!.textColor,
        ),
        back: MonthCard(
          toDateCardList: toDayCardList,
          onTap: onTap,
          isSelected: isSelected,
          isOnTap: isOnTap && isSelected,
          month: month,
          monthImageUrl: monthDiary?.backImage?.url ?? '',
          openSetting: openSetting,
          cacheImage: backCacheImageFile,
          backgroundColor: monthDiary == null
              ? MonthCardColor.white
              : monthDiary!.backgroundColor,
          textColor:
              monthDiary == null ? MonthCardColor.grey : monthDiary!.textColor,
        ),
      ),
    );
  }
}
