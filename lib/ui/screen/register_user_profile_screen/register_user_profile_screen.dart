import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../application/state/auth_state/auth_controller_provider.dart';
import '../../../application/state/auth_state/auth_state.dart';
import '../../../application/state/user_state/user_controller_provider.dart';
import '../../../model/enums/gender.dart';
import '../../../services/image_picker/pick_image.dart';
import '../../../services/permission/check_permission.dart';
import '../../../utility/show_request_permission_dialog.dart';
import '../../components/widgets/buttons/gender_select_button.dart';
import '../../components/widgets/buttons/round_border_button.dart';
import '../../components/widgets/cupertino_date_time_picker.dart';

class RegisterUserProfileScreen extends ConsumerStatefulWidget {
  const RegisterUserProfileScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const RegisterUserProfileScreen(),
    );
  }

  @override
  _RegisterUserProfileScreenState createState() =>
      _RegisterUserProfileScreenState();
}

class _RegisterUserProfileScreenState
    extends ConsumerState<RegisterUserProfileScreen> {
  String? familyName;
  String? firstName;
  String? displayName;
  File? _imageFile;
  DateTime? _birthday;
  Gender? _selectedGender;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMMMd('ja');

    final userController = ref.read(userControllerProvider.notifier);
    final authController = ref.read(authControllerProvider.notifier);
    final authState = ref.read(authControllerProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('???????????????????????????'),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'assets/input.png',
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () async {
                              final permissionStatus = await checkPhotoAccess();
                              if (permissionStatus ==
                                  PermissionStatus.granted) {
                                final file = await pickImage();
                                setState(() {
                                  _imageFile = file;
                                });
                              } else if (permissionStatus ==
                                      PermissionStatus.denied ||
                                  permissionStatus ==
                                      PermissionStatus.permanentlyDenied) {
                                await showRequestPermissionDialog(
                                  context,
                                  text: '????????????????????????????????????????????????????????????',
                                  description: '???????????????????????????????????????????????????????????????????????????',
                                );
                              }
                            },
                            child: Stack(
                              alignment: const AlignmentDirectional(1.2, 1.2),
                              children: [
                                Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: _imageFile == null
                                      ? Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: theme.disabledColor,
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            size: 60,
                                          ),
                                        )
                                      : Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
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
                                labelText: '??????????????????',
                                labelStyle: theme.textTheme.caption,
                                fillColor: theme.backgroundColor,
                              ),
                              maxLength: 12,
                              initialValue: displayName,
                              onChanged: (String value) {
                                setState(() {
                                  displayName = value;
                                });
                              },
                            ),
                            const SizedBox(height: 24),
                            Text(
                              '??????',
                              style: theme.textTheme.caption,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                GenderSelectButton(
                                  text: Gender.man.name,
                                  gender: Gender.man,
                                  selectedGender: _selectedGender,
                                  setGender: () => setState(
                                      () => _selectedGender = Gender.man),
                                ),
                                const SizedBox(width: 32),
                                GenderSelectButton(
                                  text: Gender.woman.name,
                                  gender: Gender.woman,
                                  selectedGender: _selectedGender,
                                  setGender: () => setState(
                                      () => _selectedGender = Gender.woman),
                                ),
                                const SizedBox(width: 32),
                                GenderSelectButton(
                                  text: Gender.other.name,
                                  gender: Gender.other,
                                  selectedGender: _selectedGender,
                                  setGender: () => setState(
                                      () => _selectedGender = Gender.other),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              '????????????',
                              style: theme.textTheme.caption,
                            ),
                            const SizedBox(height: 4),
                            RoundBorderButton(
                              elevation: 0,
                              // width: MediaQuery.of(context).size.width / 1.5,
                              borderColor: _birthday == null
                                  ? theme.disabledColor
                                  : theme.primaryColorLight,
                              backgroundColor: theme.backgroundColor,
                              borderWidth: _birthday == null ? 1 : 2,
                              onPressed: () async {
                                if (theme.platform == TargetPlatform.iOS) {
                                  await showCupertinoModalPopup<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CupertinoDateTimePicker(
                                        initDateTime: _birthday,
                                        onDateTimeChanged:
                                            (DateTime newDateTime) {
                                          setState(
                                              () => _birthday = newDateTime);
                                        },
                                        maximumYear: DateTime.now().year,
                                      );
                                    },
                                  );
                                } else if (theme.platform ==
                                    TargetPlatform.android) {
                                  final date = await showDatePicker(
                                    context: context,
                                    locale: const Locale('ja'),
                                    currentDate: _birthday,
                                    initialDate:
                                        DateTime(DateTime.now().year - 20),
                                    firstDate:
                                        DateTime(DateTime.now().year - 70),
                                    lastDate: DateTime.now(),
                                  );
                                  setState(() {
                                    _birthday = date;
                                  });
                                }
                              },
                              text: _birthday == null
                                  ? '????????????????????????'
                                  : dateFormat.format(_birthday!),
                              textStyle: theme.textTheme.subtitle2,
                            ),
                            const SizedBox(height: 32),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _canRegister(
                                displayName: displayName,
                                birthday: _birthday,
                                gender: _selectedGender,
                              )
                                  ? () async {
                                      await EasyLoading.show(status: '');

                                      final uid = authState.authUser?.uid;

                                      if (uid == null) return;
                                      await userController.setUserProfile(
                                        uid: uid,
                                        displayName: displayName!,
                                        birthday: _birthday!,
                                        gender: _selectedGender!,
                                        imageFile: _imageFile,
                                      );

                                      authController.setAuthState(
                                        AuthStatus.registerPartner,
                                      );

                                      await EasyLoading.dismiss();
                                    }
                                  : null,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '??????',
                                  style: theme.textTheme.button?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

bool _canRegister({
  required String? displayName,
  required DateTime? birthday,
  required Gender? gender,
}) {
  return (displayName?.isNotEmpty ?? false) &&
      birthday != null &&
      gender != null;
}
