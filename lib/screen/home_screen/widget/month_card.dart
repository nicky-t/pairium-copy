import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../model/enums/month.dart';

class MonthCard extends StatelessWidget {
  const MonthCard({
    required this.month,
    required this.selectedMonth,
    required this.isOnTap,
    required this.toDateCardList,
    required this.openSetting,
    this.monthImageUrl = '',
    this.onTap,
  });

  final Month month;
  final Month selectedMonth;
  final String monthImageUrl;
  final bool isOnTap;
  final Function() toDateCardList;
  final Function()? onTap;
  final Function()? openSetting;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      onLongPress: openSetting,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: month == selectedMonth
              ? const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: Offset(0, 15),
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
          image: monthImageUrl.isNotEmpty
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(monthImageUrl),
                )
              : null,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isOnTap && month == selectedMonth ? Colors.black45 : null,
          ),
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Text(
                month.number.toString(),
                style: theme.textTheme.headline3
                    ?.copyWith(fontFamily: IFonts().kCabin),
              ),
              Positioned(
                top: 48,
                child: Text(
                  month.shortName,
                  style: theme.textTheme.headline4
                      ?.copyWith(fontFamily: IFonts().kCabin),
                ),
              ),
              if (isOnTap && month == selectedMonth)
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: toDateCardList,
                    icon: const Icon(
                      Icons.calendar_today_sharp,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              if (isOnTap && month == selectedMonth)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: openSetting,
                    icon: const Icon(
                      Icons.keyboard_control_sharp,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
