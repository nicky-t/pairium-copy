import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../constants.dart';
import '../../model/enums/month.dart';
import '../day_card_llist_screen/day_card_list_screen.dart';
import 'month_card.dart';

class HomeScreen extends StatefulHookWidget {
  const HomeScreen();

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GlobalKey<FlipCardState>> cardKeys =
      Month.values.map((e) => GlobalKey<FlipCardState>()).toList();

  int selectedMonth = 1;
  double reverseIconAngle = 0;

  bool isOnTap = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyHeight = MediaQuery.of(context).size.height;
    final bodyWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              kAppName,
              style: theme.textTheme.headline5
                  ?.copyWith(fontFamily: IFonts().kAppTitle),
            ),
            Text(
              'JUN/6',
              style: theme.textTheme.headline6
                  ?.copyWith(fontFamily: IFonts().kCabin),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {
                throw UnimplementedError('年月日を選択する機能が実装されていません');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '2021',
                    style: theme.textTheme.headline5?.copyWith(
                      fontFamily: IFonts().kCabin,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down_sharp),
                ],
              ),
            ),
            SizedBox(
              height: bodyHeight * 0.5,
              width: bodyWidth,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: 12,
                onPageChanged: (int selectedIndex) {
                  setState(() {
                    selectedMonth = selectedIndex + 1;
                    isOnTap = false;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 40,
                    ),
                    child: FlipCard(
                      key: cardKeys[index],
                      flipOnTouch: false,
                      front: MonthCard(
                        toDayCardList: () {
                          Navigator.of(context).push(DayCardListScreen.route(
                              receivedMonth: Month.values[index].number));
                        },
                        onTap: () {
                          setState(() {
                            isOnTap = !isOnTap;
                          });
                        },
                        // TODO(al-rosa): monthCardの設定画面を開く機能を追加,https://github.com/nicky-t/pairium/issues/8
                        openSetting: () {},
                        month: Month.values[index].number,
                        monthEnglish: Month.values[index].shortName,
                        selectedMonth: selectedMonth,
                        monthImageUrl:
                            'https://pbs.twimg.com/media/DLX4h5nU8AAiQyj.jpg',
                        isOnTap: isOnTap,
                      ),
                      back: Container(
                        color: Colors.pink,
                      ),
                    ),
                  );
                },
              ),
            ),
            Transform.rotate(
              angle: reverseIconAngle,
              child: IconButton(
                onPressed: () {
                  cardKeys[selectedMonth - 1].currentState?.toggleCard();
                  setState(() {
                    reverseIconAngle += 3.14 / 2;
                  });
                },
                icon: Icon(
                  Icons.autorenew_outlined,
                  size: 32,
                  color: theme.accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
