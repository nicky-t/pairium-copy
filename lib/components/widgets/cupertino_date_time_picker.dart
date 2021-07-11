import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDateTimePicker extends StatelessWidget {
  const CupertinoDateTimePicker({
    required this.initDateTime,
    required this.onDateTimeChanged,
    this.maximumYear,
    Key? key,
  }) : super(key: key);

  final DateTime? initDateTime;
  final Function(DateTime newDateTime) onDateTimeChanged;
  final int? maximumYear;

  Widget _bottomPicker(Widget picker) {
    return Container(
      height: 256,
      padding: const EdgeInsets.only(top: 6),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          color: CupertinoColors.black,
          fontSize: 22,
        ),
        child: GestureDetector(
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
              bottom: BorderSide(
                color: Color(0xff999999),
                width: 0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              /// クパチーノデザインのボタン表示
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                child: const Text('キャンセル'),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                child: const Text('追加'),
              )
            ],
          ),
        ),

        /// 最下部で表示するPicker
        _bottomPicker(CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          maximumYear: maximumYear,
          initialDateTime: initDateTime,
          onDateTimeChanged: onDateTimeChanged,
        )),
      ],
    );
  }
}
