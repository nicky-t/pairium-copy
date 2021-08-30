import 'package:flutter/material.dart';

import '../../../components/widgets/bottom_sheet_bar.dart';
import '../../../constants.dart';
import 'color_pallet.dart';

class EditMonthCordBottomSheet extends StatelessWidget {
  const EditMonthCordBottomSheet({
    Key? key,
    required this.uploadImage,
  }) : super(key: key);

  final Future<void> Function(String type) uploadImage;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Column(
              children: [
                const BottomSheetBar(),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AddMonthCardImageButton(
                            onTap: () => uploadImage('front')),
                        const SizedBox(height: 20),
                        AddMonthCardImageButton(
                            onTap: () => uploadImage('back')),
                        const SizedBox(height: 20),
                        const _ExpansionPalette(
                          title: '文字の色',
                          icon: Icons.edit,
                        ),
                        const SizedBox(height: 20),
                        const _ExpansionPalette(
                          title: 'カードの色',
                          icon: Icons.card_membership,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddMonthCardImageButton extends StatelessWidget {
  const AddMonthCardImageButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.photo,
                    color: theme.textTheme.headline1?.color,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '表の写真',
                    style: theme.textTheme.headline6?.copyWith(
                      fontFamily: IFonts().kCabin,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpansionPalette extends StatelessWidget {
  const _ExpansionPalette({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

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
                Icon(
                  icon,
                  color: theme.textTheme.headline1?.color,
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
              SizedBox(
                height: 240,
                child: ColorPallet(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
