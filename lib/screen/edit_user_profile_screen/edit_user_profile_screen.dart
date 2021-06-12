import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/widgets/buttons/gender_select_button.dart';
import '../../components/widgets/buttons/round_border_button.dart';
import '../../components/widgets/cupertino_date_time_picker.dart';
import '../../model/enums/gender.dart';
import '../../model/user/user_document.dart';
import '../../utility/show_request_permission_dialog.dart';
import '../../view_model/edit_user_profile_view_model/edit_user_profile_view_model_provider.dart';

class EditUserProfileScreen extends StatefulHookWidget {
  const EditUserProfileScreen(this.userDoc);

  static Route<void> route({required UserDocument userDoc}) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => EditUserProfileScreen(userDoc),
    );
  }

  final UserDocument userDoc;

  @override
  _EditUserProfileScreenState createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  String? displayName;
  File? _imageFile;
  DateTime? _birthday;
  Gender? _selectedGender;

  @override
  void initState() {
    displayName = widget.userDoc.entity.displayName;
    _birthday = widget.userDoc.entity.birthday;
    _selectedGender = widget.userDoc.entity.gender;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = widget.userDoc.entity;
    final dateFormat = DateFormat.yMMMd('ja');

    final viewModel = useProvider(editUserProfileViewModelProvider);

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: theme.backgroundColor,
        title: Text(
          'プロフィール編集',
          style: theme.textTheme.subtitle1,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final permissionStatus = await viewModel.checkPhotoAccess();
                    print(permissionStatus);
                    if (permissionStatus == PermissionStatus.granted) {
                      final file = await viewModel.updateImage();
                      setState(() {
                        _imageFile = file;
                      });
                    } else if (permissionStatus == PermissionStatus.denied ||
                        permissionStatus ==
                            PermissionStatus.permanentlyDenied) {
                      await showRequestPermissionDialog(
                        context,
                        text: 'ライブラリへのアクセスを許可してください',
                        description: '画像を設定するのにライブラリへのアクセスが必要です',
                      );
                    }
                  },
                  child: Stack(
                    alignment: const AlignmentDirectional(1.2, 1.2),
                    children: [
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: user.mainProfileImage == null
                            ? Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: theme.disabledColor,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 60,
                                ),
                              )
                            : _imageFile == null
                                ? Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          user.mainProfileImage!.url,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(_imageFile!),
                                      ),
                                    ),
                                  ),
                      ),
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: theme.cardColor,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: theme.primaryColor,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  TextFormField(
                    style: theme.textTheme.bodyText2,
                    decoration: InputDecoration(
                      labelText: 'ニックネーム',
                      labelStyle: theme.textTheme.caption,
                      fillColor: theme.backgroundColor,
                    ),
                    maxLength: 10,
                    initialValue: displayName,
                    onChanged: (String value) {
                      setState(() {
                        displayName = value;
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '性別',
                    style: theme.textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      GenderSelectButton(
                        text: Gender.man.name,
                        gender: Gender.man,
                        selectedGender: _selectedGender,
                        setGender: () =>
                            setState(() => _selectedGender = Gender.man),
                      ),
                      const SizedBox(width: 20),
                      GenderSelectButton(
                        text: Gender.woman.name,
                        gender: Gender.woman,
                        selectedGender: _selectedGender,
                        setGender: () =>
                            setState(() => _selectedGender = Gender.woman),
                      ),
                      const SizedBox(width: 20),
                      GenderSelectButton(
                        text: Gender.other.name,
                        gender: Gender.other,
                        selectedGender: _selectedGender,
                        setGender: () =>
                            setState(() => _selectedGender = Gender.other),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '生年月日',
                    style: theme.textTheme.subtitle1,
                  ),
                  const SizedBox(height: 8),
                  RoundBorderButton(
                    elevation: 0,
                    width: double.infinity,
                    borderColor: _birthday == null
                        ? theme.disabledColor
                        : theme.primaryColor,
                    backgroundColor:
                        _birthday == null ? theme.highlightColor : Colors.white,
                    borderWidth: 2,
                    onPressed: () async {
                      if (theme.platform == TargetPlatform.iOS) {
                        await showCupertinoModalPopup<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return CupertinoDateTimePicker(
                              initDateTime: _birthday,
                              onDateTimeChanged: (DateTime newDateTime) {
                                setState(() => _birthday = newDateTime);
                              },
                              maximumYear: DateTime.now().year,
                            );
                          },
                        );
                      } else if (theme.platform == TargetPlatform.android) {
                        final date = await showDatePicker(
                          context: context,
                          locale: const Locale('ja'),
                          currentDate: _birthday,
                          initialDate: DateTime(DateTime.now().year - 20),
                          firstDate: DateTime(DateTime.now().year - 70),
                          lastDate: DateTime.now(),
                        );
                        setState(() {
                          _birthday = date;
                        });
                      }
                    },
                    text: _birthday == null
                        ? '選択してください'
                        : dateFormat.format(_birthday!),
                    textStyle:
                        (theme.textTheme.subtitle1)!.copyWith(fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: viewModel.canRegister(
                      displayName: displayName,
                      birthday: _birthday,
                      gender: _selectedGender,
                    )
                        ? () async {
                            await viewModel.setUserProfile(
                              displayName: displayName!,
                              birthday: _birthday!,
                              gender: _selectedGender!,
                            );
                          }
                        : null,
                    child: const Text('送信'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}