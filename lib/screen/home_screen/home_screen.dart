import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../constants.dart';
import '../../model/enums/month.dart';
import '../../model/enums/month_card_color.dart';
import '../../state/month_diary_state/month_diary_state_provider.dart';
import '../../state/user_state/user_stream_provider.dart';
import '../../utility/upload_image.dart';
import '../../view_model/home_view_model.dart';
import '../day_card_list_screen/day_card_list_screen.dart';
import 'screen_state/home_state_provider.dart';
import 'widget/edit_month_cord_bottom_sheet.dart';
import 'widget/flip_month_card.dart';
import 'widget/select_year_popup.dart';
import 'widget/spin_button.dart';

final frontCacheImageFileProvider = StateProvider<File?>((ref) => null);
final backCacheImageFileProvider = StateProvider<File?>((ref) => null);

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const HomeScreen(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<GlobalKey<FlipCardState>> cardKeys =
      Month.values.map((_) => GlobalKey<FlipCardState>()).toList();

  final PreloadPageController _controller = PreloadPageController(
    viewportFraction: 0.85,
    initialPage: DateTime.now().month - 1,
  );

  Month selectedMonth = Month.values[DateTime.now().month - 1];
  bool isOnTap = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(homeViewModel);
    final userStream = ref.watch(userStreamProvider).data?.value;
    final monthDiaryState =
        ref.watch(monthDiaryStateProvider(userStream?.entity));
    final selectedYear = ref.watch(selectedYearStateProvider);
    final frontCacheImageFile = ref.watch(frontCacheImageFileProvider);
    final backCacheImageFile = ref.watch(backCacheImageFileProvider).state;

    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: IColors.kScaffoldColor,
      appBar: AppBar(
        backgroundColor: IColors.kScaffoldColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              kAppName,
              style: theme.textTheme.headline5
                  ?.copyWith(fontFamily: IFonts().kAppTitle, fontSize: 26),
            ),
            Text(
              '${Month.values[DateTime.now().month - 1].shortName}/${DateTime.now().day}',
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
              onPressed: () async {
                await SelectYearDialog(
                  context,
                ).showSelectYearPopup(
                  selectedMonth: selectedMonth,
                  controller: _controller,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    selectedYear.toString(),
                    style: theme.textTheme.headline5?.copyWith(
                      fontFamily: IFonts().kCabin,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down_sharp),
                ],
              ),
            ),
            SizedBox(
              height: screenWidth * 1.05,
              width: screenWidth,
              child: PreloadPageView.builder(
                controller: _controller,
                itemCount: 12,
                onPageChanged: (int index) {
                  setState(() {
                    selectedMonth = Month.values[index];
                    isOnTap = false;
                  });
                },
                itemBuilder: (context, index) {
                  final monthDiaryDocs = monthDiaryState.monthDiaryDocs;
                  final monthDiaryDoc = monthDiaryDocs.firstWhereOrNull(
                    (monthDiary) =>
                        monthDiary?.entity.monthNumber == index + 1 &&
                        monthDiary?.entity.year == selectedYear,
                  );
                  return FlipMonthCard(
                    cardKey: cardKeys[index],
                    monthDiary: monthDiaryDoc?.entity,
                    month: Month.values[index],
                    isSelected: selectedMonth == Month.values[index],
                    isOnTap: isOnTap,
                    frontCacheImageFile: frontCacheImageFile.state,
                    backCacheImageFile: backCacheImageFile,
                    toDayCardList: () {
                      Navigator.of(context).push(
                        DayCardListScreen.route(
                          month: selectedMonth,
                          year: selectedYear,
                        ),
                      );
                    },
                    onTap: () {
                      setState(() {
                        isOnTap = !isOnTap;
                      });
                    },
                    openSetting: () => _showBottomSheet(
                      backgroundColor: monthDiaryDoc?.entity.backgroundColor ??
                          MonthCardColor.white,
                      textColor: monthDiaryDoc?.entity.textColor ??
                          MonthCardColor.grey,
                      frontImage: monthDiaryDoc?.entity.frontImage?.url ?? '',
                      backImage: monthDiaryDoc?.entity.backImage?.url ?? '',
                      context: context,
                      uploadImage: (type) async {
                        await uploadImage(
                          context: context,
                          setFile: (file) {
                            if (type == 'front') {
                              ref.read(frontCacheImageFileProvider).state =
                                  file;
                            } else {
                              ref.read(backCacheImageFileProvider).state = file;
                            }
                          },
                        );
                      },
                      updataMonthDairy: (
                          {MonthCardColor? backgroundColor,
                          MonthCardColor? textColor}) async {
                        print('up:$frontCacheImageFile');
                        await viewModel.updateMonthDairy(
                          month: selectedMonth,
                          monthDiaryDoc: monthDiaryDoc,
                          frontImage: frontCacheImageFile.state,
                          backImage: backCacheImageFile,
                          backgroundColor: backgroundColor,
                          textColor: textColor,
                        );
                        ref.read(frontCacheImageFileProvider).state = null;
                        ref.read(backCacheImageFileProvider).state = null;
                      },
                    ),
                  );
                },
              ),
            ),
            SpinButton(
              onPressed: () =>
                  cardKeys[selectedMonth.index].currentState?.toggleCard(),
            ),
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet({
  required BuildContext context,
  required Future<void> Function(String type) uploadImage,
  required Future<void> Function(
          {MonthCardColor backgroundColor, MonthCardColor textColor})
      updataMonthDairy,
  required MonthCardColor backgroundColor,
  required MonthCardColor textColor,
  required String frontImage,
  required String backImage,
}) {
  var selectedBackgroundColor = backgroundColor;
  var selectedTextColor = textColor;
  showModalBottomSheet<Widget>(
    isScrollControlled: true,
    backgroundColor: IColors.kScaffoldColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return EditMonthCordBottomSheet(
          uploadImage: (type) async => uploadImage(type),
          frontImage: frontImage,
          backImage: backImage,
          selectedBackgroundColor: selectedBackgroundColor,
          selectedTextColor: selectedTextColor,
          onSelectedBackgroundColor: (MonthCardColor color) {
            setState(() {
              selectedBackgroundColor = color;
            });
          },
          onSelectedTextColor: (MonthCardColor color) {
            setState(() {
              selectedTextColor = color;
            });
          },
        );
      });
    },
  ).whenComplete(() {
    updataMonthDairy(
        backgroundColor: selectedBackgroundColor, textColor: selectedTextColor);
  });
}
