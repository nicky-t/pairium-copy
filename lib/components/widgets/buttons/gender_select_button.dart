import 'package:flutter/material.dart';

import '../../../model/enums/gender.dart';

class GenderSelectButton extends StatelessWidget {
  const GenderSelectButton({
    required this.text,
    required this.gender,
    required this.selectedGender,
    required this.setGender,
    Key? key,
  }) : super(key: key);

  final String text;
  final Gender gender;
  final Gender? selectedGender;
  final void Function() setGender;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: setGender,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
        side: BorderSide(
          width: selectedGender == gender ? 2 : 1,
          color: selectedGender == gender
              ? Theme.of(context).primaryColor
              : Theme.of(context).disabledColor,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: selectedGender == gender
              ? Theme.of(context).primaryColor
              : Theme.of(context).disabledColor,
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
