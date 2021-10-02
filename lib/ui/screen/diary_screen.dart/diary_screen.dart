import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../application/state/diary_state/diary_state.dart';
import '../../../application/state/diary_state/diary_state_provider.dart';
import '../../../constants.dart';
import '../../../model/entity/diary/diary.dart';
import '../../../model/entity/diary/diary_document.dart';
import '../../../model/entity/diary/diary_image/diary_image.dart';
import '../../../model/enums/month.dart';
import '../../../utility/show_confirm_dialog.dart';
import '../../../utility/upload_image.dart';
import '../day_card_list_screen/day_card_list_screen.dart';
import '../edit_diary_screen.dart/edit_diary_screen.dart';
import '../full_image_screen/full_image_screen.dart';

final _diaryProvider = Provider<Diary>((_) => throw UnimplementedError());
final _diaryImageProvider = Provider<DiaryImage>(
  (_) => throw UnimplementedError(),
);

class DiaryScreen extends ConsumerStatefulWidget {
  const DiaryScreen({required this.date, Key? key}) : super(key: key);

  static Route<void> route({required DateTime date}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) {
        return DiaryScreen(date: date);
      },
    );
  }

  final DateTime date;

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends ConsumerState<DiaryScreen> {
  late final DiaryStateParam _diaryStateParam;
  File? imageFile;
  bool isSelectedMode = false;
  List<DiaryImage> selectedImages = [];

  @override
  void initState() {
    _diaryStateParam = DiaryStateParam(
      year: widget.date.year,
      month: widget.date.month,
      day: widget.date.day,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final dateFormat = DateFormat('yyyy/MM/dd E');

    final diaryDoc =
        ref.watch(selectedDiaryStateProvider(_diaryStateParam)).data?.value;

    if (diaryDoc == null) return const CircularProgressIndicator();
    final diary = diaryDoc.entity;

    final diaryController =
        ref.read(dayDiariesControllerProvider(_diaryStateParam).notifier);

    final heroTag = '${HeroTag.kDiary}-${diaryDoc.entity.year}-'
        '${diaryDoc.entity.month}-${diaryDoc.entity.day}';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          dateFormat.format(diary.date),
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
                    diaryDoc: diaryDoc,
                    onSelectMode: () {
                      setState(() {
                        isSelectedMode = true;
                      });
                    },
                    deleteDiary: () async {
                      await diaryController.deleteDiary(
                        diaryDoc: diaryDoc,
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

                                  final newImages = diary.images
                                      .where(
                                        (diaryImage) => !selectedImages
                                            .contains(diaryImage),
                                      )
                                      .toList();
                                  await diaryController.deleteImages(
                                    newImages: newImages,
                                    deleteImages: selectedImages,
                                    diaryDoc: diaryDoc,
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
                          imageProvider: NetworkImage(diary.mainImage.url),
                          heroTag: '$heroTag-mainImage',
                          imageUrl: diary.mainImage.url,
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
                              image: NetworkImage(diary.mainImage.url),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (diary.title.isNotEmpty)
                  Center(
                    child: Text(
                      diary.title,
                      style: theme.textTheme.headline6
                          ?.copyWith(fontFamily: IFonts().kCabin),
                    ),
                  ),
                const SizedBox(height: 16),
                if (diary.description.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      diary.description,
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
                ...diary.images
                    .map(
                      (e) => ProviderScope(
                        overrides: [
                          _diaryImageProvider.overrideWithValue(e),
                          _diaryProvider.overrideWithValue(diary),
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
                          await diaryController.addImage(
                            diaryDoc: diaryDoc,
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
  required Future<void> Function() deleteDiary,
  required VoidCallback onSelectMode,
  required DiaryDocument diaryDoc,
}) async {
  if (Platform.isIOS) {
    await showModalBottomSheet<void>(
      context: context,
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
                      EditDiaryScreen.route(
                        diaryDoc: diaryDoc,
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
                        await deleteDiary();
                        await Navigator.pushAndRemoveUntil(
                          context,
                          DayCardListScreen.route(
                            month: Month.values.firstWhere(
                              (month) => month.number == diaryDoc.entity.month,
                            ),
                            year: diaryDoc.entity.year,
                          ),
                          (route) => false,
                        );
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
  final void Function(DiaryImage) onSelectImage;
  final void Function(DiaryImage) unSelectImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final diary = ref.watch(_diaryProvider);
    final diaryImage = ref.watch(_diaryImageProvider);

    final heroTag = '${HeroTag.kDiary}-${diary.year}-'
        '${diary.month}-${diary.day}';

    return GestureDetector(
      onTap: () async {
        if (isSelectMode) {
          if (isSelected) {
            unSelectImage(diaryImage);
          } else {
            onSelectImage(diaryImage);
          }
        } else {
          await Navigator.of(context).push(
            FullImageScreen.route(
              imageProvider: CachedNetworkImageProvider(
                diaryImage.image.url,
              ),
              heroTag: '$heroTag-${diary.images.indexOf(diaryImage)}',
              imageUrl: diaryImage.image.url,
            ),
          );
        }
      },
      child: Stack(
        children: [
          Hero(
            tag: '$heroTag-${diary.images.indexOf(diaryImage)}',
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    diaryImage.image.url,
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
