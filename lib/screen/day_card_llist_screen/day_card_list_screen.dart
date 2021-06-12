import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../constants.dart';
import 'day_card.dart';

class DayCardListScreen extends StatefulHookWidget {
  const DayCardListScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const DayCardListScreen(),
    );
  }

  @override
  _DayCardListScreenState createState() => _DayCardListScreenState();
}

class _DayCardListScreenState extends State<DayCardListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyHeight = MediaQuery.of(context).size.height;
    final bodyWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JUNE / 2021',
          style: theme.textTheme.headline6?.copyWith(
            fontFamily: IFonts().kCabin,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: bodyWidht,
          height: bodyHeight,
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.all(8),
                  child: DayCard(
                    day: '1',
                    date: 'wed',
                  ),
                );
              }),
        ),
      ),
    );
  }
}
