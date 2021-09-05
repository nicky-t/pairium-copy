import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../constants.dart';
import '../../model/day_diary/day_diary.dart';
import '../../model/day_diary/day_diary_document.dart';
import '../../model/day_diary/day_diary_image/day_diary_image.dart';
import '../../state/day_diary_state/day_diary_state_provider.dart';
import '../../utility/upload_image.dart';
import '../../view_model/day_diary_view_model.dart';
import '../edit_day_diary_screen.dart/edit_day_diary_screen.dart';
import '../full_image_screen/full_image_screen.dart';

final _dayDiaryProvider = Provider<DayDiary>((_) => throw UnimplementedError());
final _dayDiaryImageProvider = Provider<DayDiaryImage>(
  (_) => throw UnimplementedError(),
);

class DayDiaryScreen extends ConsumerStatefulWidget {
  const DayDiaryScreen({required this.dayDiaryDoc, Key? key}) : super(key: key);

  static Route<void> route({required DayDiaryDocument dayDiaryDoc}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) {
        return DayDiaryScreen(
          dayDiaryDoc: dayDiaryDoc,
        );
      },
    );
  }

  final DayDiaryDocument dayDiaryDoc;

  @override
  _DayDiaryScreenState createState() => _DayDiaryScreenState();
}

class _DayDiaryScreenState extends ConsumerState<DayDiaryScreen> {
  File? imageFile;

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
          Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () async {
                await _showBottomSheet(
                  deleteDayDiary: () async {
                    await dayDiaryNotifier.deleteDayDiary(
                      dayDiaryDoc: dayDiaryDoc,
                      year: dayDiary.year,
                      month: dayDiary.month,
                    );

                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                );
              },
              icon: const Icon(
                Icons.keyboard_control_sharp,
                size: 32,
              ),
            ),
          )
        ],
      ),
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
                if (dayDiary.title != null && dayDiary.title!.isNotEmpty)
                  Center(
                    child: Text(
                      dayDiary.title!,
                      style: theme.textTheme.headline6
                          ?.copyWith(fontFamily: IFonts().kCabin),
                    ),
                  ),
                const SizedBox(height: 16),
                if (dayDiary.description != null &&
                    dayDiary.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      dayDiary.description!,
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
                        child: const _ImageListItem(),
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
                            dayDiaryDoc: widget.dayDiaryDoc,
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

  Future<void> _showBottomSheet({
    required Future<void> Function() deleteDayDiary,
  }) async {
    final theme = Theme.of(context);

    if (Platform.isIOS) {
      await showBarModalBottomSheet<Widget>(
        context: context,
        barrierColor: Colors.black45,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) {
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
                              dayDiaryDoc: widget.dayDiaryDoc));
                    },
                    leading: const Icon(Icons.edit_outlined),
                    title: Text(
                      '編集',
                      style: theme.textTheme.subtitle1?.copyWith(
                        color:
                            theme.textTheme.subtitle1?.color?.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: theme.disabledColor,
                  ),
                  ListTile(
                    onTap: () async {
                      // TODO 選択処理の追加
                    },
                    leading: const Icon(Icons.select_all_outlined),
                    title: Text(
                      '選択',
                      style: theme.textTheme.subtitle1?.copyWith(
                        color:
                            theme.textTheme.subtitle1?.color?.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: theme.disabledColor,
                  ),
                  ListTile(
                    onTap: () async {
                      await deleteDayDiary();
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
}

class _ImageListItem extends ConsumerWidget {
  const _ImageListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dayDiary = ref.watch(_dayDiaryProvider);
    final dayDiaryImage = ref.watch(_dayDiaryImageProvider);

    final heroTag = '${HeroTag.kDayDiary}-${dayDiary.year}-'
        '${dayDiary.month}-${dayDiary.day}';

    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          FullImageScreen.route(
            imageProvider: CachedNetworkImageProvider(
              dayDiaryImage.image.url,
            ),
            heroTag: '$heroTag-${dayDiary.images.indexOf(dayDiaryImage)}',
          ),
        );
      },
      child: Hero(
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
    );
  }
}
