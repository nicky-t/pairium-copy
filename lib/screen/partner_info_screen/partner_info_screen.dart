import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../components/widgets/cupertino_date_time_picker.dart';
import '../../../constants.dart';
import '../../../model/user/user.dart';
import '../../../view_model/partner_info_view_model.dart';
import '../../model/partner/partner.dart';

class PartnerInfoScreen extends ConsumerStatefulWidget {
  const PartnerInfoScreen({
    required this.pair,
    required this.partner,
    Key? key,
  }) : super(key: key);

  static Route<void> route({
    required User pair,
    required Partner partner,
  }) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => PartnerInfoScreen(
        pair: pair,
        partner: partner,
      ),
    );
  }

  final User pair;
  final Partner partner;

  @override
  _PartnerInfoScreenState createState() => _PartnerInfoScreenState();
}

class _PartnerInfoScreenState extends ConsumerState<PartnerInfoScreen> {
  DateTime? _anniversary;

  @override
  void initState() {
    _anniversary = widget.partner.anniversary;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final birthFormat = DateFormat.MMMd('ja');

    final viewModel = ref.read(partnerInfoViewModelProvider);

    return WillPopScope(
      onWillPop: () async {
        if (widget.partner.anniversary != _anniversary) {
          await viewModel.updateAnniversary(_anniversary);
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Partner'),
        ),
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 5.5),
            _AnniversaryButton(
              anniversary: _anniversary,
              partner: widget.partner,
              setAnniversary: (date) {
                setState(() {
                  _anniversary = date;
                });
              },
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.pair.mainProfileImage == null)
                  Material(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: theme.disabledColor,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 64,
                      ),
                    ),
                  )
                else
                  Material(
                    elevation: 12,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(
                            widget.pair.mainProfileImage!.url,
                          ),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 32),
                Column(
                  children: [
                    Text(
                      widget.pair.displayName,
                      style: theme.textTheme.headline6
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    widget.pair.birthday == DateTime.now()
                        ? AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                '誕生日'
                                '${birthFormat.format(widget.pair.birthday)}',
                                textStyle: theme.textTheme.subtitle1!.copyWith(
                                  color: theme.textTheme.caption?.color,
                                  fontWeight: FontWeight.bold,
                                ),
                                colors: [
                                  IColors.kPrimary,
                                  theme.colorScheme.primaryVariant,
                                  IColors.kPrimarySecondary,
                                  theme.colorScheme.secondaryVariant,
                                ],
                              ),
                            ],
                            pause: const Duration(seconds: 2),
                            isRepeatingAnimation: true,
                          )
                        : Text(
                            '誕生日 ${birthFormat.format(widget.pair.birthday)}',
                            style: theme.textTheme.subtitle1?.copyWith(
                              color: theme.textTheme.caption?.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AnniversaryButton extends StatelessWidget {
  const _AnniversaryButton({
    required this.anniversary,
    required this.partner,
    required this.setAnniversary,
    Key? key,
  }) : super(key: key);

  final DateTime? anniversary;
  final Partner partner;

  final void Function(DateTime?) setAnniversary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMMMd('ja');

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        primary: theme.backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      ),
      onPressed: () async {
        if (theme.platform == TargetPlatform.iOS) {
          await showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) {
              return CupertinoDateTimePicker(
                initDateTime: anniversary,
                onDateTimeChanged: setAnniversary,
                maximumYear: DateTime.now().year,
              );
            },
          );
        } else if (theme.platform == TargetPlatform.android) {
          final date = await showDatePicker(
            context: context,
            locale: const Locale('ja'),
            currentDate: anniversary,
            initialDate: DateTime(DateTime.now().year - 1),
            firstDate: DateTime(DateTime.now().year - 70),
            lastDate: DateTime.now(),
          );
          setAnniversary(date);
        }
      },
      child: anniversary == null && partner.anniversary == null
          ? Text(
              '記念日の設定',
              style: theme.textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            )
          : partner.anniversary == anniversary
              ? IgnorePointer(
                  ignoring: true,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        '記念日'
                        ' ${dateFormat.format(partner.anniversary!)}',
                        textStyle: theme.textTheme.headline6!
                            .copyWith(fontWeight: FontWeight.bold),
                        colors: [
                          IColors.kPrimary,
                          theme.colorScheme.primaryVariant,
                          IColors.kPrimarySecondary,
                          theme.colorScheme.secondaryVariant,
                        ],
                      ),
                    ],
                    pause: const Duration(seconds: 2),
                    isRepeatingAnimation: true,
                    onTap: null,
                  ),
                )
              : Text(
                  '記念日'
                  ' ${dateFormat.format(anniversary!)}',
                  style: theme.textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
    );
  }
}
