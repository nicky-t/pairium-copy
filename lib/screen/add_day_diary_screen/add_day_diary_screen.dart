import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../components/widgets/cupertino_date_time_picker.dart';
import '../../constants.dart';
import '../../state/day_diary_state/day_diary_state.dart';
import '../../state/day_diary_state/day_diary_state_provider.dart';
import '../../utility/upload_image.dart';
import '../../view_model/add_day_card_view_model.dart';

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

  DateTime _date = DateTime.now();
  DateTime _cupertinoPickerDate = DateTime.now();
  File? _imageFile;
  String? _imageUrl;
  bool isShowFloating = true;

  @override
  void initState() {
    ref.read(addDayCardViewModelProvider).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final dateFormat = DateFormat('yyyy/MM/dd E');

    final viewModel = ref.read(addDayCardViewModelProvider);
    final dayDiaryState = ref.watch(dayDiaryStateProvider);

    if (dayDiaryState.isFetching) const CircularProgressIndicator();

    ref.listen<DayDiaryState>(dayDiaryStateProvider, (state) {
      if (state.isFetching) return;
      final dayDiary = state.dayDiaryDocs.first?.entity;
      _titleController.text = dayDiary?.title ?? '';
      _descController.text = dayDiary?.description ?? '';
      _imageUrl = dayDiary?.mainImage.url;
    });

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
                await _showMyDatePicker(theme.platform, viewModel);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.disabledColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
                child: Text(
                  dateFormat.format(_date),
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
                    await EasyLoading.show(status: 'loading...');

                    if (dayDiaryState.dayDiaryDocs.first == null) {
                      await viewModel.setDayDairy(
                        date: _date,
                        title: _titleController.text,
                        description: _descController.text,
                        mainImage: _imageFile!,
                      );
                    } else {
                      await viewModel.updateDayDairy(
                        dayDiaryDoc: dayDiaryState.dayDiaryDocs.first!,
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
                      gradient: LinearGradient(colors: [
                        theme.primaryColorDark,
                        theme.primaryColor,
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
                      // TODO 画像ローディング中にタッチイベントを消す
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
                                  const Icon(Icons.camera_alt, size: 48),
                                  Positioned(
                                    bottom: (screenSize.width - 80) * 0.9 / 2,
                                    left: (screenSize.width - 80) / 2 + 8,
                                    child: const Center(
                                      child: SizedBox(
                                        width: 20,
                                        child: CircleAvatar(
                                          child: Icon(Icons.add, size: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: _imageFile != null
                                      ? DecorationImage(
                                          image: FileImage(_imageFile!),
                                          fit: BoxFit.cover,
                                        )
                                      : DecorationImage(
                                          image: NetworkImage(_imageUrl!),
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
                    style: theme.textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
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
  }

  Future<void> _showMyDatePicker(
    TargetPlatform platform,
    AddDayCardViewModel viewModel,
  ) async {
    if (platform == TargetPlatform.iOS) {
      await showCupertinoModalPopup<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoDateTimePicker(
            initDateTime: _date,
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() => _cupertinoPickerDate = newDateTime);
            },
            maximumYear: DateTime.now().year,
            onPressedComplete: () {
              setState(() {
                _date = _cupertinoPickerDate;
              });
              _titleController.text = '';
              _descController.text = '';
              _imageUrl = null;
              viewModel.fetchDiary(_date);
            },
          );
        },
      );
    } else if (platform == TargetPlatform.android) {
      final date = await showDatePicker(
        context: context,
        locale: const Locale('ja'),
        currentDate: _date,
        initialDate: DateTime(DateTime.now().year - 20),
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime.now(),
      );
      if (date == null) return;
      setState(() {
        _date = date;
      });
      _titleController.text = '';
      _descController.text = '';
      _imageUrl = null;
      await viewModel.fetchDiary(_date);
    }
  }
}
