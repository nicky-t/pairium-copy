import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../components/widgets/buttons/gradient_button.dart';

class EditPartnerScreen extends HookWidget {
  const EditPartnerScreen({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const EditPartnerScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final viewModel = useProvider(editPartnerViewModelProvider);

    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Partner'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: Column(
              children: [
                Text(
                  '自分のID: ',
                  style: theme.textTheme.subtitle1
                      ?.copyWith(color: theme.textTheme.caption?.color),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.primaryColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: theme.primaryColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    labelText: 'パートナーのID...',
                  ),
                ),
                const SizedBox(height: 24),
                GradientButton(
                  text: 'パートナーを登録する',
                  onPressed: () {},
                ),
                // GradientButton(
                //   text: 'QRコードを読み取る',
                //   icon: Icons.qr_code,
                //   onPressed: () async {
                //     final permissionStatus =
                //await viewModel.checkCameraAccess();
                //     if (permissionStatus == PermissionStatus.granted) {
                //       final result = await Navigator.push<String>(
                //           context, QRReadScreen.route());
                //       print(result);
                //     } else if (permissionStatus == PermissionStatus.denied ||
                //         permissionStatus ==
                // PermissionStatus.permanentlyDenied) {
                //       await showRequestPermissionDialog(
                //         context,
                //         text: 'カメラへのアクセスを許可してください',
                //         description: 'QRコードを読み取る為にカメラを利用します',
                //       );
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
