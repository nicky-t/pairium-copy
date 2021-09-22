import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../constants.dart';
import '../../model/day_diary/day_diary.dart';
import '../../model/day_diary/day_diary_document.dart';
import '../../model/day_diary/day_diary_image/day_diary_image.dart';
import '../../state/day_diary_state/day_diary_state_provider.dart';
import '../../utility/show_confirm_dialog.dart';
import '../../utility/upload_image.dart';
import '../../view_model/day_diary_view_model.dart';
import '../edit_day_diary_screen.dart/edit_day_diary_screen.dart';
import '../full_image_screen/full_image_screen.dart';

final _dayDiaryProvider = Provider<DayDiary>((_) => throw UnimplementedError());
final _dayDiaryImageProvider = Provider<DayDiaryImage>(
  (_) => throw UnimplementedError(),
);

class DayDiaryScreen extends ConsumerStatefulWidget {
  const DayDiaryScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) {
        return const DayDiaryScreen();
      },
    );
  }

  @override
  _DayDiaryScreenState createState() => _DayDiaryScreenState();
}

class _DayDiaryScreenState extends ConsumerState<DayDiaryScreen> {
  File? imageFile;
  bool isSelectedMode = false;
  List<DayDiaryImage> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final dateFormat = DateFormat('yyyy/MM/dd E');

    final dayDiaryDoc = ref.watch(selectedDayDiaryStateProvider);
    final dayDiary = dayDiaryDoc!.entity;

    final viewModel = ref.read(dayDiaryViewModelProvider);

    final dayDiaryNotifier = ref.read(dayDiaryStateProvider.notifier);

    final heroTag = '${HeroTag.kDayDiary}-${dayDiaryDoc.entity.year}-'
        '${dayDiaryDoc.entity.month}-${dayDiaryDoc.entity.day}';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          dateFormat.format(dayDiary.date),
          style: theme.textTheme.subtitle1?.copyWith(
            fontFamily: IFonts().kCabin,
          ),
        ),
        actions: [
          Builder(builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                onPressed: () async {
                  if (isSelectedMode) return;
                  await _showBottomSheet(
                    context: context,
                    dayDiaryDoc: dayDiaryDoc,
                    onSelectMode: () {
                      setState(() {
                        isSelectedMode = true;
                      });
                    },
                    deleteDayDiary: () async {
                      await dayDiaryNotifier.deleteDayDiary(
                        dayDiaryDoc: dayDiaryDoc,
                        year: dayDiary.year,
                        month: dayDiary.month,
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.keyboard_control_sharp,
                  size: 32,
                ),
              ),
            );
          })
        ],
      ),
      bottomNavigationBar: isSelectedMode
          ? Container(
              color: IColors.kScaffoldColor,
              padding: const EdgeInsets.only(bottom: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 64,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          selectedImages = [];
                          isSelectedMode = false;
                        });
                      },
                      icon: Icon(
                        Icons.close,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  Text(
                    selectedImages.isEmpty
                        ? '項目を選択'
                        : '${selectedImages.length}項目を選択中',
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 64,
                    child: IconButton(
                      onPressed: selectedImages.isEmpty
                          ? null
                          : () async {
                              await showConfirmDialog(
                                context,
                                text: '本当に削除しますか？',
                                description: 'この写真はpairium上から完全に削除されます。',
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await EasyLoading.show(status: '');

                                  final newImages = dayDiary.images
                                      .where(
                                        (dayDiaryImage) => !selectedImages
                                            .contains(dayDiaryImage),
                                      )
                                      .toList();
                                  await viewModel.deleteImages(
                                    newImages: newImages,
                                    deleteImages: selectedImages,
                                    dayDiaryDoc: dayDiaryDoc,
                                  );

                                  ref
                                          .read(selectedDayDiaryStateProvider
                                              .notifier)
                                          .state =
                                      await viewModel.fetchDayDiaryDoc(
                                          dayDiaryDoc: dayDiaryDoc);

                                  await dayDiaryNotifier.fetchDayDiaries(
                                    year: dayDiary.year,
                                    month: dayDiary.month,
                                  );
                                  setState(() {
                                    selectedImages = [];
                                    isSelectedMode = false;
                                  });

                                  await EasyLoading.dismiss();
                                },
                              );
                            },
                      icon: Icon(
                        Icons.delete_outline,
                        color: theme.errorColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      await Navigator.of(context).push(
                        FullImageScreen.route(
                          imageProvider: NetworkImage(dayDiary.mainImage.url),
                          heroTag: '$heroTag-mainImage',
                          imageUrl: dayDiary.mainImage.url,
                        ),
                      );
                    },
                    child: Hero(
                      tag: '$heroTag-mainImage',
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
                  ),
                ),
                const SizedBox(height: 16),
                if (dayDiary.title.isNotEmpty)
                  Center(
                    child: Text(
                      dayDiary.title,
                      style: theme.textTheme.headline6
                          ?.copyWith(fontFamily: IFonts().kCabin),
                    ),
                  ),
                const SizedBox(height: 16),
                if (dayDiary.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      dayDiary.description,
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
                ...dayDiary.images
                    .map(
                      (e) => ProviderScope(
                        overrides: [
                          _dayDiaryImageProvider.overrideWithValue(e),
                          _dayDiaryProvider.overrideWithValue(dayDiary),
                        ],
                        child: _ImageListItem(
                          isSelectMode: isSelectedMode,
                          isSelected: selectedImages.contains(e),
                          onSelectImage: (image) {
                            setState(() {
                              selectedImages = [...selectedImages, image];
                            });
                          },
                          unSelectImage: (image) {
                            final newImages = selectedImages
                                .where(
                                    (dayDairyImage) => dayDairyImage != image)
                                .toList();
                            setState(() {
                              selectedImages = newImages;
                            });
                          },
                        ),
                      ),
                    )
                    .toList(),
                Container(
                  color: Colors.grey.shade400,
                  child: IconButton(
                    onPressed: () {
                      uploadImage(
                        context: context,
                        setFile: (file) {
                          setState(() {
                            imageFile = file;
                          });
                        },
                        uploadImage: () async {
                          await viewModel.addImage(
                            dayDiaryDoc: dayDiaryDoc,
                            file: imageFile,
                          );
                        },
                      );
                    },
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

Future<void> _showBottomSheet({
  required BuildContext context,
  required Future<void> Function() deleteDayDiary,
  required VoidCallback onSelectMode,
  required DayDiaryDocument dayDiaryDoc,
}) async {
  if (Platform.isIOS) {
    await showModalBottomSheet<void>(
      context: context,
      // barrierColor: Colors.black45,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        final theme = Theme.of(context);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      EditDayDiaryScreen.route(
                        dayDiaryDoc: dayDiaryDoc,
                      ),
                    );
                  },
                  leading: const Icon(Icons.edit_outlined),
                  title: Text(
                    '編集',
                    style: theme.textTheme.subtitle1?.copyWith(
                      color: theme.textTheme.subtitle1?.color?.withOpacity(0.8),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: theme.disabledColor,
                ),
                ListTile(
                  onTap: () {
                    onSelectMode();
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.select_all_outlined),
                  title: Text(
                    '選択',
                    style: theme.textTheme.subtitle1?.copyWith(
                      color: theme.textTheme.subtitle1?.color?.withOpacity(0.8),
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  color: theme.disabledColor,
                ),
                ListTile(
                  onTap: () async {
                    await showConfirmDialog(
                      context,
                      text: '本当に削除しますか？',
                      description: 'この写真はpairium上から完全に削除されます。',
                      onPressed: () async {
                        await deleteDayDiary();
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
                  },
                  leading: const Icon(Icons.delete_outline),
                  title: Text(
                    '削除',
                    style: theme.textTheme.subtitle1?.copyWith(
                      color: theme.errorColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  } else {
    await showMaterialModalBottomSheet<Widget>(
      context: context,
      builder: (context) {
        // TODO Android用のUIを用意する
        return Container();
      },
    );
  }
}

class _ImageListItem extends ConsumerWidget {
  const _ImageListItem({
    required this.isSelected,
    required this.isSelectMode,
    required this.onSelectImage,
    required this.unSelectImage,
    Key? key,
  }) : super(key: key);

  final bool isSelected;
  final bool isSelectMode;
  final void Function(DayDiaryImage) onSelectImage;
  final void Function(DayDiaryImage) unSelectImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayDiary = ref.watch(_dayDiaryProvider);
    final dayDiaryImage = ref.watch(_dayDiaryImageProvider);

    final heroTag = '${HeroTag.kDayDiary}-${dayDiary.year}-'
        '${dayDiary.month}-${dayDiary.day}';

    return GestureDetector(
      onTap: () async {
        if (isSelectMode) {
          if (isSelected) {
            unSelectImage(dayDiaryImage);
          } else {
            onSelectImage(dayDiaryImage);
          }
        } else {
          await Navigator.of(context).push(
            FullImageScreen.route(
              imageProvider: CachedNetworkImageProvider(
                dayDiaryImage.image.url,
              ),
              heroTag: '$heroTag-${dayDiary.images.indexOf(dayDiaryImage)}',
              imageUrl: dayDiaryImage.image.url,
            ),
          );
        }
      },
      child: Stack(
        children: [
          Hero(
            tag: '$heroTag-${dayDiary.images.indexOf(dayDiaryImage)}',
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    dayDiaryImage.image.url,
                  ),
                  fit: BoxFit.fill,
                ),
                color: Theme.of(context).disabledColor.withOpacity(0.1),
              ),
            ),
          ),
          if (isSelected)
            Container(
              color: Colors.white30,
            ),
          if (isSelected)
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            )
        ],
      ),
    );
  }
}
