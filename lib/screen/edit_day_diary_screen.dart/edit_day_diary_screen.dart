import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';
import '../../model/day_diary/day_diary_document.dart';
import '../../utility/upload_image.dart';
import '../../view_model/edit_day_diary_view_model.dart';

class EditDayDiaryScreen extends ConsumerStatefulWidget {
  const EditDayDiaryScreen({
    required this.dayDiaryDoc,
    Key? key,
  }) : super(key: key);

  static Route<void> route({required DayDiaryDocument dayDiaryDoc}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) {
        return EditDayDiaryScreen(
          dayDiaryDoc: dayDiaryDoc,
        );
      },
    );
  }

  final DayDiaryDocument dayDiaryDoc;

  @override
  _EditDayDiaryScreenState createState() => _EditDayDiaryScreenState();
}

class _EditDayDiaryScreenState extends ConsumerState<EditDayDiaryScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  File? _imageFile;
  String? _imageUrl;
  bool isShowFloating = true;

  @override
  void initState() {
    _titleController.text = widget.dayDiaryDoc.entity.title ?? '';
    _descController.text = widget.dayDiaryDoc.entity.description ?? '';
    _imageUrl = widget.dayDiaryDoc.entity.mainImage.url;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    final viewModel = ref.read(editDayDiaryViewModelProvider);

    return WillPopScope(
      onWillPop: () async {
        FocusScope.of(context).unfocus();
        await Future<void>.delayed(const Duration(milliseconds: 300));
        Navigator.pop(context);
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: IColors.kScaffoldColor,
          appBar: AppBar(
            backgroundColor: IColors.kScaffoldColor,
          ),
          floatingActionButton: _imageFile != null || _imageUrl != null
              ? FloatingActionButton(
                  onPressed: () async {
                    await EasyLoading.show(status: '');

                    await viewModel.updateDayDairy(
                      dayDiaryDoc: widget.dayDiaryDoc,
                      title: _titleController.text,
                      description: _descController.text,
                      mainImage: _imageFile,
                    );

                    await viewModel.fetchDayDiary(
                      dayDiaryDoc: widget.dayDiaryDoc,
                    );

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
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
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
                                  Positioned(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          color: Colors.black54,
                                          padding: const EdgeInsets.all(16),
                                          child: const Icon(
                                            Icons.camera_alt,
                                            size: 48,
                                            color: Colors.white70,
                                          ),
                                        ),
                                        const Positioned(
                                          top: -2,
                                          right: 6,
                                          child: Center(
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
                                    ),
                                  )
                                ],
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
}
