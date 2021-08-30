import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'color_pallet.dart';

class ExpansionPalett extends StatelessWidget {
  const ExpansionPalett({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
          ),
          child: ExpansionTile(
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
            title: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 0,
                          offset: const Offset(2, 2))
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: theme.textTheme.headline6?.copyWith(
                    fontFamily: IFonts().kCabin,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            textColor: Colors.black,
            initiallyExpanded: true,
            children: const [
              SizedBox(height: 240, child: ColorPallet(),),
            ],
          ),
        ),
      ),
    );
  }
}
