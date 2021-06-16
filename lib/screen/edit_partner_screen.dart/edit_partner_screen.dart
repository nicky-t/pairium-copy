import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/widgets/buttons/gradient_button.dart';
import '../../utility/show_request_permission_dialog.dart';
import '../../view_model/edit_partner_view_model.dart';
import '../qr_read_screen/qr_read_screen.dart';

class EditPartnerScreen extends HookWidget {
  const EditPartnerScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const EditPartnerScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = useProvider(editPartnerViewModelProvider);

    // final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Partner'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24, top: 12),
          child: GradientButton(
            text: 'QRコードを読み取る',
            icon: Icons.qr_code,
            onPressed: () async {
              final permissionStatus = await viewModel.checkCameraAccess();
              print(permissionStatus);
              if (permissionStatus == PermissionStatus.granted) {
                await Navigator.push(context, QRReadScreen.route());
              } else if (permissionStatus == PermissionStatus.denied ||
                  permissionStatus == PermissionStatus.permanentlyDenied) {
                await showRequestPermissionDialog(
                  context,
                  text: 'カメラへのアクセスを許可してください',
                  description: 'QRコードを読み取る為にカメラを利用します',
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
