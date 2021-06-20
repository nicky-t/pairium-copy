import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../model/enums/month.dart';

class MonthCard extends StatelessWidget {
  const MonthCard({
    required this.month,
    required this.isSelected,
    required this.isOnTap,
    required this.monthImageUrl,
    required this.toDateCardList,
    required this.openSetting,
    required this.onTap,
    required this.cacheImage,
  });

  final Month month;
  final bool isSelected;
  final bool isOnTap;
  final String monthImageUrl;
  final Function() toDateCardList;
  final Function() openSetting;
  final Function() onTap;
  final File? cacheImage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      onLongPress: openSetting,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: isSelected
              ? const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: Offset(0, 15),
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade200,
        ),
        child: Stack(
          children: [
            if (monthImageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: monthImageUrl,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => cacheImage != null
                    ? Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: FileImage(cacheImage!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
                // ignore: implicit_dynamic_parameter
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: isOnTap ? 0.7 : 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black45,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            month.number.toString(),
                            style: theme.textTheme.headline3
                                ?.copyWith(fontFamily: IFonts().kCabin),
                          ),
                          Text(
                            month.shortName,
                            style: theme.textTheme.headline4
                                ?.copyWith(fontFamily: IFonts().kCabin),
                          ),
                        ],
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isOnTap ? 1 : 0,
                        child: IconButton(
                          onPressed: isOnTap ? toDateCardList : null,
                          icon: const Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isOnTap ? 1 : 0,
                      child: IconButton(
                        onPressed: isOnTap ? openSetting : null,
                        icon: const Icon(
                          Icons.keyboard_control_sharp,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
