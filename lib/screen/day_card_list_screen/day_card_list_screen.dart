import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../model/enums/month.dart';
import 'day_card.dart';

class DayCardListScreen extends ConsumerStatefulWidget {
  const DayCardListScreen(this.month, {Key? key}) : super(key: key);

  final Month month;

  static Route<void> route({required Month month}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) {
        return DayCardListScreen(month);
      },
    );
  }

  @override
  _DayCardListScreenState createState() => _DayCardListScreenState();
}

class _DayCardListScreenState extends ConsumerState<DayCardListScreen> {
  final List<Widget> cardList = const [
    Padding(
      padding: EdgeInsets.all(8),
      child: DayCard(
        day: '1',
        date: 'wed',
      ),
    ),
    Padding(
      padding: EdgeInsets.all(8),
      child: DayCard(
        day: '1',
        date: 'wed',
      ),
    ),
    Padding(
      padding: EdgeInsets.all(8),
      child: DayCard(
        day: '1',
        date: 'wed',
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '2021',
          style: theme.textTheme.headline6?.copyWith(
            fontFamily: IFonts().kCabin,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              throw UnimplementedError('メニューを開く機能が実装されていません');
            },
            icon: const Icon(Icons.menu_open),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ...cardList,
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
