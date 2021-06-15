import 'package:flutter/material.dart';

import '../../constants.dart';

class DayCard extends StatelessWidget {
  const DayCard({
    required this.day,
    required this.date,
    this.dayImageUrl = '',
  });

  final String dayImageUrl;
  final String day;
  final String date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyWidth = MediaQuery.of(context).size.width;
    final bodyHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        throw UnimplementedError('dayCardをタップした処理が実装されていません');
      },
      child: Container(
        height: bodyHeight / 5,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 8),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          color: theme.backgroundColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: bodyWidth / 3.5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day,
                    style: theme.textTheme.headline4?.copyWith(
                      fontFamily: IFonts().kCabin,
                    ),
                  ),
                  Text(
                    date,
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontFamily: IFonts().kCabin,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: Colors.grey.shade200,
                  image: dayImageUrl.isNotEmpty
                      ? const DecorationImage(
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          image: AssetImage('assets/welcome.jpg'),
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
