import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../components/widgets/bottom_sheet_bar.dart';
import '../../constants.dart';
import '../../model/enums/month.dart';
import '../../model/month_diary/month_diary_document.dart';
import '../../state/home_state/home_state_provider.dart';
import '../../state/home_state/state_of_flip_card.dart';
import '../../state/month_diary/month_diary_state_provider.dart';
import '../../utility/crop_image.dart';
import '../../utility/show_request_permission_dialog.dart';
import '../../view_model/home_view_model.dart';
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
  final List<GlobalKey<FlipCardState>> cardKeys =
      Month.values.map((_) => GlobalKey<FlipCardState>()).toList();

  Month selectedMonth = Month.january;

  @override
  void initState() {
    super.initState();

    final nowMonth = DateTime.now().month;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read(isOnTapFlipStates[Month.values[nowMonth - 1].name]!).state =
          const StateOfFlipCard(isSelected: true);
    });
  }

  Widget _monthCards({
    required HomeViewModel viewModel,
    required List<MonthDiaryDocument?> monthDiaryDocs,
  }) {
    return PreloadPageView.builder(
      preloadPagesCount: 12,
      controller: PreloadPageController(
          viewportFraction: 0.85, initialPage: DateTime.now().month - 1),
      itemCount: 12,
      onPageChanged: (int selectedIndex) {
        final beforePageState =
            context.read(isOnTapFlipStates[selectedMonth.name]!).state;
        if (beforePageState.isOnTap) {
          context.read(isOnTapFlipStates[selectedMonth.name]!).state =
              beforePageState.copyWith(isSelected: false, isOnTap: false);
        }

        selectedMonth = Month.values[selectedIndex];

        final currentPageState =
            context.read(isOnTapFlipStates[selectedMonth.name]!).state;
        context.read(isOnTapFlipStates[selectedMonth.name]!).state =
            currentPageState.copyWith(isSelected: true);
      },
      itemBuilder: (context, index) {
        final monthDiaryDoc = monthDiaryDocs.firstWhereOrNull(
          (monthDiary) => monthDiary?.entity.monthNumber == index + 1,
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
    final monthDiaryState = useProvider(monthDiaryStateProvider);

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
              height: screenHeight * 0.5,
              width: screenWidth,
              child: _monthCards(
                viewModel: viewModel,
                monthDiaryDocs: monthDiaryState.monthDiaryDocs,
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
