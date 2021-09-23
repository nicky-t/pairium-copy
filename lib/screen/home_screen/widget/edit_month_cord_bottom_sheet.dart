import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/widgets/bottom_sheet_bar.dart';
import '../../../constants.dart';
import '../../../model/enums/month_card_color.dart';
import '../home_screen.dart';
import 'color_pallet.dart';

class EditMonthCordBottomSheet extends ConsumerWidget {
  const EditMonthCordBottomSheet({
    required this.frontImage,
    required this.backImage,
    required this.uploadImage,
    required this.selectedBackgroundColor,
    required this.selectedTextColor,
    required this.onSelectedBackgroundColor,
    required this.onSelectedTextColor,
    Key? key,
  }) : super(key: key);

  final Future<void> Function(String type) uploadImage;
  final String frontImage;
  final String backImage;
  final MonthCardColor selectedBackgroundColor;
  final MonthCardColor selectedTextColor;
  final void Function(MonthCardColor) onSelectedBackgroundColor;
  final void Function(MonthCardColor) onSelectedTextColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final frontCacheImageFile = ref.watch(frontCacheImageFileProvider).state;
    final backCacheImageFile = ref.watch(backCacheImageFileProvider).state;

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
                          onTap: () {
                            uploadImage('front');
                          },
                          title: '表の写真',
                          cacheImage: frontCacheImageFile,
                          image: frontImage,
                        ),
                        const SizedBox(height: 20),
                        AddMonthCardImageButton(
                          onTap: () => uploadImage('back'),
                          title: '裏の写真',
                          cacheImage: backCacheImageFile,
                          image: backImage,
                        ),
                        const SizedBox(height: 20),
                        _ExpansionPalette(
                          title: 'カードの色',
                          selectedColor: selectedBackgroundColor,
                          onSelectedColor: onSelectedBackgroundColor,
                        ),
                        const SizedBox(height: 20),
                        _ExpansionPalette(
                          title: '文字の色',
                          selectedColor: selectedTextColor,
                          onSelectedColor: onSelectedTextColor,
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
    required this.title,
    required this.image,
    this.cacheImage,
  }) : super(key: key);

  final VoidCallback onTap;
  final String title;
  final File? cacheImage;
  final String image;

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
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      image: cacheImage != null
                          ? DecorationImage(
                              image: FileImage(cacheImage!),
                              fit: BoxFit.cover,
                            )
                          : image.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(image),
                                  fit: BoxFit.cover,
                                )
                              : null,
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
    required this.selectedColor,
    required this.onSelectedColor,
  }) : super(key: key);

  final String title;
  final MonthCardColor selectedColor;
  final void Function(MonthCardColor) onSelectedColor;

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
                    color: selectedColor.color,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                          color: selectedColor.color.withOpacity(0.5),
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
            children: [
              SizedBox(
                height: 240,
                child: ColorPallet(
                  onSelectedColor: onSelectedColor,
                  selectedColor: selectedColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
