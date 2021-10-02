import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../application/state/diary_state/diary_state.dart';
import '../../../application/state/diary_state/diary_state_provider.dart';
import '../../../constants.dart';
import '../../../model/entity/diary/diary_document.dart';
import '../../../utility/upload_image.dart';
import '../../components/widgets/cupertino_date_time_picker.dart';
import '../error_screen.dart';

final _dateProvider = StateProvider((ref) => DateTime.now());

final _diaryParamProvider = Provider(
  (ref) {
    final _date = ref.watch(_dateProvider).state;
    return DiaryStateParam(
      year: _date.year,
      month: _date.month,
      day: _date.day,
    );
  },
);

class AddDayCardScreen extends ConsumerStatefulWidget {
  const AddDayCardScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: const AddDayCardScreen(),
        );
      },
    );
  }

  @override
  _AddDayCardScreenState createState() => _AddDayCardScreenState();
}

class _AddDayCardScreenState extends ConsumerState<AddDayCardScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  late final DiaryStateParam param;

  DateTime _cupertinoPickerDate = DateTime.now();
  File? _imageFile;
  String? _imageUrl;
  bool isFirstBuild = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final dateFormat = DateFormat('yyyy/MM/dd E');

    final _date = ref.watch(_dateProvider);
    final _diaryParam = ref.watch(_diaryParamProvider);

    final diaryController = ref.read(dayDiariesControllerProvider(
      _diaryParam,
    ).notifier);

    return ref.watch(selectedDiaryStateProvider(_diaryParam)).when(
          data: (selectedDiaryDoc) {
            ref.listen<AsyncValue<DiaryDocument?>>(
                selectedDiaryStateProvider(_diaryParam), (state) {
              final diary = state.data?.value?.entity;
              if (diary == null) return;
              _titleController.text = diary.title;
              _descController.text = diary.description;
              _imageUrl = diary.mainImage.url;
            });
            if (selectedDiaryDoc != null && isFirstBuild) {
              _titleController.text = selectedDiaryDoc.entity.title;
              _descController.text = selectedDiaryDoc.entity.description;
              _imageUrl = selectedDiaryDoc.entity.mainImage.url;
              isFirstBuild = false;
            }

            return WillPopScope(
              onWillPop: () async {
                FocusScope.of(context).unfocus();
                await Future<void>.delayed(const Duration(milliseconds: 300));
                Navigator.pop(context);
                return Future.value(false);
              },
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                onHorizontalDragUpdate: (details) {
                  if (details.delta.dx > 18 && details.globalPosition.dx < 80) {
                    Navigator.pop(context);
                  }
                },
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: IColors.kScaffoldColor,
                  appBar: AppBar(
                    backgroundColor: IColors.kScaffoldColor,
                    title: GestureDetector(
                      onTap: () async {
                        await _showMyDatePicker(theme.platform);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.disabledColor),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 32),
                        child: Text(
                          dateFormat.format(_date.state),
                          style: theme.textTheme.bodyText2?.copyWith(
                            fontFamily: IFonts().kCabin,
                          ),
                        ),
                      ),
                    ),
                  ),
                  floatingActionButton: _imageFile != null || _imageUrl != null
                      ? FloatingActionButton(
                          onPressed: () async {
                            await EasyLoading.show(status: '');

                            if (selectedDiaryDoc == null) {
                              await diaryController.setDayDairy(
                                date: _date.state,
                                title: _titleController.text,
                                description: _descController.text,
                                mainImage: _imageFile!,
                              );
                            } else {
                              await diaryController.updateDayDairy(
                                selectedDiaryDoc: selectedDiaryDoc,
                                title: _titleController.text,
                                description: _descController.text,
                                mainImage: _imageFile,
                              );
                            }
                            await EasyLoading.dismiss();
                            Navigator.pop(context);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    theme.primaryColorDark,
                                    theme.primaryColor,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                              shape: BoxShape.circle,
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.white.withOpacity(0.1),
                                highlightColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                child: Icon(
                                  Icons.check_outlined,
                                  color: theme.backgroundColor,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        )
                      : null,
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await uploadImage(
                                context: context,
                                setFile: (file) {
                                  setState(() {
                                    _imageFile = file;
                                  });
                                },
                              );
                            },
                            child: Center(
                              child: Container(
                                width: screenSize.width - 80,
                                height: (screenSize.width - 80) * 0.9,
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
                                child: _imageFile == null && _imageUrl == null
                                    ? Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          const Icon(Icons.camera_alt,
                                              size: 48),
                                          Positioned(
                                            bottom: (screenSize.width - 80) *
                                                0.9 /
                                                2,
                                            left:
                                                (screenSize.width - 80) / 2 + 8,
                                            child: const Center(
                                              child: SizedBox(
                                                width: 20,
                                                child: CircleAvatar(
                                                  child:
                                                      Icon(Icons.add, size: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: _imageFile != null
                                              ? DecorationImage(
                                                  image: FileImage(_imageFile!),
                                                  fit: BoxFit.cover,
                                                )
                                              : DecorationImage(
                                                  image:
                                                      NetworkImage(_imageUrl!),
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _titleController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'タイトル',
                              hintStyle: theme.textTheme.subtitle1?.copyWith(
                                color: theme.disabledColor,
                                fontWeight: FontWeight.bold,
                              ),
                              fillColor: Colors.transparent,
                            ),
                            maxLength: 20,
                            style: theme.textTheme.subtitle1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: TextFormField(
                              controller: _descController,
                              maxLines: 12,
                              minLines: 12,
                              decoration: InputDecoration(
                                hintText: 'その日の出来事や思い出を記録しまししょう',
                                hintStyle: theme.textTheme.caption,
                                fillColor: Colors.transparent,
                                border: InputBorder.none,
                              ),
                              maxLength: 300,
                              style: theme.textTheme.subtitle2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (_, __) => const ErrorScreen(),
        );
  }

  Future<void> _showMyDatePicker(
    TargetPlatform platform,
  ) async {
    if (platform == TargetPlatform.iOS) {
      await showCupertinoModalPopup<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoDateTimePicker(
            initDateTime: ref.read(_dateProvider).state,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() => _cupertinoPickerDate = newDateTime);
            },
            maximumYear: DateTime.now().year,
            onPressedComplete: () {
              setState(() {
                ref.read(_dateProvider).state = _cupertinoPickerDate;
              });
              _titleController.text = '';
              _descController.text = '';
              _imageFile = null;
              _imageUrl = null;
            },
          );
        },
      );
    } else if (platform == TargetPlatform.android) {
      final date = await showDatePicker(
        context: context,
        locale: const Locale('ja'),
        currentDate: ref.read(_dateProvider).state,
        initialDate: DateTime(DateTime.now().year - 20),
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime.now(),
      );
      if (date == null) return;
      ref.read(_dateProvider).state = date;

      _titleController.text = '';
      _descController.text = '';
      _imageFile = null;
      _imageUrl = null;
    }
  }
}
