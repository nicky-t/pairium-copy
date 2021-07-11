import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../components/widgets/bottom_sheet_bar.dart';
import '../../constants.dart';
import '../../model/enums/month.dart';
import '../../model/month_diary/month_diary_document.dart';
import '../../state/month_diary/month_diary_state_provider.dart';
import '../../state/user_state/user_stream_provider.dart';
import '../../utility/crop_image.dart';
import '../../utility/show_request_permission_dialog.dart';
import '../../view_model/home_view_model.dart';
import 'screen_state/home_state_provider.dart';
import 'widget/flip_month_card.dart';
import 'widget/spin_button.dart';

extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

class HomeScreen extends HookWidget {
  HomeScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => HomeScreen(),
    );
  }

  final List<GlobalKey<FlipCardState>> cardKeys =
      Month.values.map((_) => GlobalKey<FlipCardState>()).toList();

  final PreloadPageController _controller = PreloadPageController(
    viewportFraction: 0.85,
    initialPage: DateTime.now().month - 1,
  );

  Widget _monthCards({
    required BuildContext context,
    required HomeViewModel viewModel,
    required List<MonthDiaryDocument?> monthDiaryDocs,
    required int selectedYear,
    required Month selectedMonth,
  }) {
    return PreloadPageView.builder(
      controller: _controller,
      itemCount: 12,
      onPageChanged: (int newSelectIndex) {
        context
            .read(selectedMonthStateProvider.notifier)
            .changeMonth(Month.values[newSelectIndex]);
      },
      itemBuilder: (context, index) {
        final monthDiaryDoc = monthDiaryDocs.firstWhereOrNull(
          (monthDiary) =>
              monthDiary?.entity.monthNumber == index + 1 &&
              monthDiary?.entity.year == selectedYear,
        );
        return FlipMonthCard(
          cardKey: cardKeys[index],
          monthDiary: monthDiaryDoc?.entity,
          month: Month.values[index],
          openSetting: () => _showBottomSheet(
            context: context,
            uploadImage: (type) async {
              final permissionStatus = await viewModel.checkPhotoAccess();
              if (permissionStatus == PermissionStatus.granted) {
                File? _frontImageFile;
                File? _backImageFile;

                final file = await viewModel.updateImage();
                if (file == null) return;
                final croppedImage = await cropImage(context, file);
                await EasyLoading.show(status: 'loading...');
                if (type == 'front') {
                  _frontImageFile = croppedImage;
                } else {
                  _backImageFile = croppedImage;
                }

                if (croppedImage != null) {
                  await viewModel.updateMonthDairy(
                    month: selectedMonth,
                    monthDiaryDoc: monthDiaryDoc,
                    frontImage: _frontImageFile,
                    backImage: _backImageFile,
                  );
                  final currentState = context
                      .read(isOnTapFlipStates[selectedMonth.name]!)
                      .state;
                  context.read(isOnTapFlipStates[selectedMonth.name]!).state =
                      currentState.copyWith(
                    frontCacheImageFile: _frontImageFile,
                    backCacheImageFile: _backImageFile,
                  );
                }
                await EasyLoading.dismiss();
              } else if (permissionStatus == PermissionStatus.denied ||
                  permissionStatus == PermissionStatus.permanentlyDenied) {
                await showRequestPermissionDialog(
                  context,
                  text: 'ライブラリへのアクセスを許可してください',
                  description: '画像を設定するのにライブラリへのアクセスが必要です',
                );
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(homeViewModel);
    final userStream = useProvider(userStreamProvider).data?.value;
    final monthDiaryState =
        useProvider(monthDiaryStateProvider(userStream?.entity));
    final selectedYear = useProvider(selectedYearStateProvider).state;
    final selectedMonth = useProvider(selectedMonthStateProvider);

    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
                await _showSelectYearPopup(context, selectedYear, _controller);
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
              height: screenHeight * 0.5,
              width: screenWidth,
              child: _monthCards(
                context: context,
                viewModel: viewModel,
                monthDiaryDocs: monthDiaryState.monthDiaryDocs,
                selectedYear: selectedYear,
                selectedMonth: selectedMonth,
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
}) {
  showModalBottomSheet<Widget>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Column(
          children: [
            const BottomSheetBar(),
            InkWell(
              onTap: () => uploadImage('front'),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('表の写真'),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
              color: Colors.black12,
            ),
            InkWell(
              onTap: () => uploadImage('back'),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('裏の写真'),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
              color: Colors.black12,
            ),
            InkWell(
              onTap: () {
                throw UnimplementedError('写真を追加する機能が追加されていません。');
              },
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('背景'),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
              color: Colors.black12,
            ),
            InkWell(
              onTap: () {
                throw UnimplementedError('写真を追加する機能が追加されていません。');
              },
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('文字'),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
              color: Colors.black12,
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _showSelectYearPopup(
  BuildContext context,
  int selectedYear,
  PreloadPageController controller,
) async {
  await showAnimatedDialog(
    context: context,
    barrierDismissible: true,
    animationType: DialogTransitionType.slideFromTop,
    duration: const Duration(milliseconds: 500),
    builder: (BuildContext context) {
      final theme = Theme.of(context);

      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height / 3 * 2,
          width: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
            color: theme.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
          child: Column(
            children: [
              Icon(
                Icons.arrow_drop_up,
                color: theme.primaryColor,
                size: 32,
              ),
              Flexible(
                child: ScrollablePositionedList.builder(
                  initialScrollIndex: 10 - (DateTime.now().year - selectedYear),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return _monthGrid(context, selectedYear, index, controller);
                  },
                ),
              ),
              Icon(
                Icons.arrow_drop_down,
                color: theme.primaryColor,
                size: 32,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _monthGrid(
  BuildContext context,
  int selectedYear,
  int index,
  PreloadPageController controller,
) {
  final theme = Theme.of(context);
  final year = DateTime.now().year - 10 + index;
  final selectedMonth = context.read(selectedMonthStateProvider);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(
      children: [
        Center(
          child: Text(
            year.toString(),
            style: theme.textTheme.headline6,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width - 82,
          child: GridView.builder(
            itemCount: 12,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: year == selectedYear && selectedMonth.index == index
                        ? theme.primaryColor
                        : theme.backgroundColor,
                  ),
                ),
                onPressed: () {
                  context.read(selectedYearStateProvider).state = year;
                  context
                      .read(selectedMonthStateProvider.notifier)
                      .changeMonth(Month.values[index]);
                  Navigator.pop(context);
                  controller.jumpToPage(index);
                },
                child: Text(
                  Month.values[index].shortName,
                  style: theme.textTheme.bodyText2?.copyWith(
                    color: year == selectedYear && selectedMonth.index == index
                        ? theme.primaryColor
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
