// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../screens/attendance_screen/attendance_screen.dart';
// import '../../screens/management_attendance_screen/management_attendance_screen.dart';
// import '../../screens/settings_screen/settings_screen.dart';
// import '../../screens/shift_confirmation_screen/shift_confirmation_screen.dart';
// import '../../screens/work_information_screen/work_information_screen.dart';
// import '../user_type_state/use_type_state.dart';

// enum BottomNavigatorType {
//   attendanceAndLeaving,
//   shiftConfirmation,
//   workInformation,
//   setting,
// }

// extension BottomNavigationTypeEx on BottomNavigatorType {
//   Widget getScreen({required UseType usingType}) {
//     final isEmployee = usingType == UseType.employee;
//     switch (this) {
//       case BottomNavigatorType.attendanceAndLeaving:
//         return isEmployee ? AttendanceScreen() :
// ManagementAttendanceScreen();
//       case BottomNavigatorType.shiftConfirmation:
//         return ShiftConfirmationScreen();
//       case BottomNavigatorType.workInformation:
//         return WorkInformationScreen();
//       case BottomNavigatorType.setting:
//         return const SettingsScreen();
//     }
//   }

//   IconData get iconData {
//     switch (this) {
//       case BottomNavigatorType.attendanceAndLeaving:
//         return Icons.work;
//       case BottomNavigatorType.shiftConfirmation:
//         return Icons.calculate;
//       case BottomNavigatorType.workInformation:
//         return Icons.store;
//       case BottomNavigatorType.setting:
//         return Icons.person;
//     }
//   }

//   String get labelString {
//     switch (this) {
//       case BottomNavigatorType.attendanceAndLeaving:
//         return '出退勤';
//       case BottomNavigatorType.shiftConfirmation:
//         return '給料計算';
//       case BottomNavigatorType.workInformation:
//         return '仕事先';
//       case BottomNavigatorType.setting:
//         return 'アカウント';
//     }
//   }
// }

// class BottomNavigatorStateNotifier extends
//StateNotifier<BottomNavigatorType> {
//   BottomNavigatorStateNotifier()
//       : super(BottomNavigatorType.attendanceAndLeaving);

//   void setCurrentBottomNavigator(int index) =>
//       state = BottomNavigatorType.values[index];
// }
