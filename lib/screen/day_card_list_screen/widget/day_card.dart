import 'package:flutter/material.dart';

import '../../../components/widgets/sticky_note.dart';
import '../../../constants.dart';
import '../../../model/enums/week_day.dart';

class DayCard extends StatelessWidget {
  const DayCard({
    required this.day,
    required this.weekDay,
    required this.dayImageUrl,
    required this.onPressed,
    this.title,
    Key? key,
  }) : super(key: key);

  final String dayImageUrl;
  final String? title;
  final int day;
  final WeekDay weekDay;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: screenHeight / 5,
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
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth / 3.5,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day.toString(),
                        style: theme.textTheme.headline4?.copyWith(
                          fontFamily: IFonts().kCabin,
                        ),
                      ),
                      Text(
                        weekDay.label,
                        style: theme.textTheme.caption?.copyWith(
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
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              image: NetworkImage(dayImageUrl),
                            )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            if (title != null && title!.isNotEmpty)
              Positioned(
                left: -10,
                top: -18,
                child: StickyNote(
                  color: const Color(0xffecd3af),
                  isPin: false,
                  width: screenWidth / 2.2,
                  height: 60,
                  child: Text(
                    title!,
                    style: theme.textTheme.subtitle2?.copyWith(
                      fontFamily: IFonts().kYomogi,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
