import 'package:flutter/material.dart';

import '../../constants.dart';

class MonthCard extends StatelessWidget {
  const MonthCard({
    required this.month,
    required this.monthEnglish,
    required this.selectedMonth,
    this.monthImageUrl = '',
  });

  final int month;
  final String monthEnglish;
  final int selectedMonth;
  final String monthImageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        throw UnimplementedError('monthCardをタップしたときの処理が実装されていません');
      },
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              month.toString(),
              style: theme.textTheme.headline3
                  ?.copyWith(fontFamily: IFonts().kCabin),
            ),
            Text(
              monthEnglish,
              style: theme.textTheme.headline4
                  ?.copyWith(fontFamily: IFonts().kCabin),
            ),
          ],
        ),
      ),
    );
  }
}
