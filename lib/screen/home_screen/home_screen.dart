import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../constants.dart';
import '../../model/enums/month.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyHeight = MediaQuery.of(context).size.height;
    final bodyWidht = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              kAppName,
              style: theme.textTheme.bodyText1
                  ?.copyWith(fontFamily: IFonts().kAppTitle, fontSize: 30),
            ),
            Text(
              'JUN/6',
              style: theme.textTheme.bodyText1
                  ?.copyWith(fontFamily: IFonts().kCabin, fontSize: 20),
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
              onPressed: () {},
              child: Text(
                '2021',
                style: theme.textTheme.bodyText1
                    ?.copyWith(fontFamily: IFonts().kCabin, fontSize: 30),
              ),
            ),
            SizedBox(
              height: bodyHeight * 0.5,
              width: bodyWidht,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.85),
                itemCount: 12,
                onPageChanged: (int selectedIndex) {
                  setState(() {
                    selectedMonth = selectedIndex + 1;
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
                        month: Month.values[index].number,
                        monthEnglish: Month.values[index].shortName,
                        selectedMonth: selectedMonth,
                        monthImageUrl:
                            'https://pbs.twimg.com/media/DLX4h5nU8AAiQyj.jpg',
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
                  size: 30,
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
