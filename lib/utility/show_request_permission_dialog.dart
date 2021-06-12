import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<void> showRequestPermissionDialog(
  BuildContext context, {
  required String text,
  required String description,
}) async {
  await Alert(
    context: context,
    type: AlertType.warning,
    title: text,
    desc: description,
    style: AlertStyle(descStyle: Theme.of(context).textTheme.bodyText2!),
    buttons: [
      DialogButton(
        color: Theme.of(context).disabledColor,
        onPressed: () => Navigator.pop(context),
        child: Text(
          'キャンセル',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Theme.of(context).cardColor),
        ),
      ),
      DialogButton(
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).colorScheme.secondary.withOpacity(0.7),
        ]),
        onPressed: () async {
          await openAppSettings();
        },
        child: Text(
          '設定',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Theme.of(context).cardColor),
        ),
      )
    ],
  ).show();
}
