import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../model/day_diary/day_diary_document.dart';

class DayDiaryScreen extends StatelessWidget {
  const DayDiaryScreen({required this.dayDiaryDoc, Key? key}) : super(key: key);

  static Route<void> route({required DayDiaryDocument dayDiaryDoc}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) {
        return DayDiaryScreen(
          dayDiaryDoc: dayDiaryDoc,
        );
      },
    );
  }

  final DayDiaryDocument dayDiaryDoc;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final dateFormat = DateFormat('yyyy/MM/dd E');

    final dayDiary = dayDiaryDoc.entity;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          dateFormat.format(dayDiary.date),
          style: theme.textTheme.subtitle1?.copyWith(
            fontFamily: IFonts().kCabin,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: Container(
                    width: screenSize.width - 40,
                    height: (screenSize.width - 40) * 0.9,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(dayDiary.mainImage.url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (dayDiary.title != null && dayDiary.title!.isNotEmpty)
                  Center(
                    child: Text(
                      dayDiary.title!,
                      style: theme.textTheme.headline6
                          ?.copyWith(fontFamily: IFonts().kCabin),
                    ),
                  ),
                const SizedBox(height: 16),
                if (dayDiary.description != null &&
                    dayDiary.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      dayDiary.description!,
                      style: theme.textTheme.subtitle2?.copyWith(
                        fontFamily: IFonts().kCabin,
                        color: theme.textTheme.caption?.color,
                      ),
                    ),
                  ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
            ),
            delegate: SliverChildListDelegate(
              [
                Container(
                  width: screenSize.width / 3,
                  height: screenSize.width / 3,
                  color: Colors.red,
                ),
                Container(
                  width: screenSize.width / 3,
                  height: screenSize.width / 3,
                  color: Colors.red,
                ),
                Container(
                  width: screenSize.width / 3,
                  height: screenSize.width / 3,
                  color: Colors.red,
                ),
                Container(
                  color: Colors.grey.shade400,
                  child: IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
