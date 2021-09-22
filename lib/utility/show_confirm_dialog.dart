import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future<void> showConfirmDialog(
  BuildContext context, {
  required String text,
  required String description,
  required Future<void> Function() onPressed,
}) async {
  await Alert(
    context: context,
    type: AlertType.warning,
    title: text,
    desc: description,
    style: AlertStyle(descStyle: Theme.of(context).textTheme.bodyText2!),
    buttons: [
      DialogButton(
        color: Theme.of(context).backgroundColor,
        onPressed: () => Navigator.pop(context),
        child: Text(
          'キャンセル',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
      DialogButton(
        color: Theme.of(context).backgroundColor,
        onPressed: () async {
          await onPressed();
        },
        child: Text(
          '写真を削除',
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Theme.of(context).errorColor),
        ),
      )
    ],
  ).show();
}
