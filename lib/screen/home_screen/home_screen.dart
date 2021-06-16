import 'dart:io';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/widgets/bottom_sheet_bar.dart';
import '../../constants.dart';
import '../../model/enums/month.dart';
import '../../model/month_diary/month_diary_document.dart';
import '../../state/month_dairy/month_dairy_stream.dart';
import '../../utility/show_request_permission_dialog.dart';
import '../../view_model/home_view_model.dart';
import 'widget/flip_month_card.dart';
import 'widget/spin_button.dart';

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
      Month.values.map((_) => GlobalKey<FlipCardState>()).toList();

  File? _frontImageFile;
  File? _backImageFile;

  Month selectedMonth = Month.january;
  double reverseIconAngle = 0;

  bool isOnTap = false;

  Widget _monthCards({
    required HomeViewModel viewModel,
    List<MonthDiaryDocument?>? monthDiaryDocs,
  }) {
    final monthDiaries = monthDiaryDocs?.map((e) => e?.entity).toList();
    return PageView.builder(
      controller: PageController(viewportFraction: 0.85),
      itemCount: 12,
      onPageChanged: (int selectedIndex) {
        setState(() {
          selectedMonth = Month.values[selectedIndex];
          isOnTap = false;
        });
      },
      itemBuilder: (context, index) {
        return FlipMonthCard(
          cardKey: cardKeys[index],
          monthDiary: monthDiaries?.firstWhere(
            (monthDiary) => monthDiary?.monthNumber == index + 1,
            orElse: () => null,
          ),
          month: Month.values[index],
          selectedMonth: selectedMonth,
          isOnTap: isOnTap,
          onTap: () {
            setState(() {
              isOnTap = !isOnTap;
            });
          },
          showBottomSheet: () => _showBottomSheet(
            context: context,
            onTap: (type) async {
              final permissionStatus = await viewModel.checkPhotoAccess();
              if (permissionStatus == PermissionStatus.granted) {
                final file = await viewModel.updateImage();
                final cropImage = await _cropImage(context, file);
                setState(() {
                  if (type == 'front') {
                    _frontImageFile = cropImage;
                  } else {
                    _backImageFile = cropImage;
                  }
                });

                if (cropImage != null) {
                  await viewModel.updateMonthDairy(
                    month: selectedMonth,
                    monthDiaryDoc: monthDiaryDocs?.firstWhere(
                      (monthDiary) =>
                          monthDiary?.entity.monthNumber == index + 1,
                      orElse: () => null,
                    ),
                    frontImage: _frontImageFile,
                    backImage: _backImageFile,
                  );
                }
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

  Future<File?> _cropImage(BuildContext context, File? imageFile) async {
    final croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile!.path,
      androidUiSettings: const AndroidUiSettings(
        statusBarColor: Colors.black,
        toolbarTitle: '',
        toolbarColor: Colors.black,
        toolbarWidgetColor: Colors.white,
        backgroundColor: Colors.black,
        cropFrameColor: Colors.transparent,
        showCropGrid: false,
        hideBottomControls: true,
        initAspectRatio: CropAspectRatioPreset.original,
      ),
      iosUiSettings: const IOSUiSettings(
        hidesNavigationBar: true,
        aspectRatioPickerButtonHidden: true,
        doneButtonTitle: '次へ',
        cancelButtonTitle: '戻る',
      ),
    );
    return croppedFile;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(homeViewModel);

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
              child: useProvider(monthDairyStreamProvider).when(
                data: (monthDiariesDocs) {
                  if (monthDiariesDocs.isEmpty) {
                    return _monthCards(viewModel: viewModel);
                  } else {
                    return _monthCards(
                      viewModel: viewModel,
                      monthDiaryDocs: monthDiariesDocs,
                    );
                  }
                },
                loading: () => _monthCards(viewModel: viewModel),
                error: (_, __) => const Center(child: Text('アプリを再起動してください')),
              ),
            ),
            SpinButton(
              reverseIconAngle: reverseIconAngle,
              onPressed: () {
                cardKeys[selectedMonth.index].currentState?.toggleCard();
                setState(() {
                  reverseIconAngle += 3.14 / 2;
                  isOnTap = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _showBottomSheet({
  required BuildContext context,
  required Future<void> Function(String type) onTap,
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
              onTap: () => onTap('front'),
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
              onTap: () => onTap('back'),
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
