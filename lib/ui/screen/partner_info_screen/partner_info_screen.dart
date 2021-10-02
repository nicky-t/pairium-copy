import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../application/state/partner_state/partner_controller_provider.dart';
import '../../../constants.dart';
import '../../../model/entity/partner/partner.dart';
import '../../../model/entity/user/user.dart';
import '../../components/widgets/cupertino_date_time_picker.dart';
import '../../components/widgets/sticky_note.dart';

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
    final size = MediaQuery.of(context).size;
    final birthFormat = DateFormat.MMMd('ja');

    final partnerController = ref.read(partnerControllerProvider.notifier);

    return WillPopScope(
      onWillPop: () async {
        if (widget.partner.anniversary != _anniversary) {
          await partnerController.updateAnniversary(_anniversary);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: IColors.kScaffoldColor,
        appBar: AppBar(
          backgroundColor: IColors.kScaffoldColor,
          title: const Text('Partner'),
        ),
        body: Container(
          margin: EdgeInsets.only(top: size.height / 7),
          padding: const EdgeInsets.all(16),
          alignment: Alignment.topCenter,
          child: StickyNote(
            width: size.width * 0.95,
            height: size.width * 0.95,
            color: theme.primaryColor,
            child: Column(
              children: [
                SizedBox(height: (size.width - 60) / 5),
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
                    if (widget.pair.mainProfileImage != null)
                      Container(
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
                    const SizedBox(width: 32),
                    Column(
                      children: [
                        Text(
                          widget.pair.displayName,
                          style: theme.textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: IFonts().kYomogi,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '誕生日 ${birthFormat.format(widget.pair.birthday)}',
                          style: theme.textTheme.subtitle1?.copyWith(
                            color: theme.textTheme.caption?.color,
                            fontWeight: FontWeight.bold,
                            fontFamily: IFonts().kYomogi,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
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

    return GestureDetector(
      onTap: () async {
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
      child: StickyNote(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 84,
        isPin: false,
        angle: 0.01,
        color: Colors.white,
        child: anniversary == null && partner.anniversary == null
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 20),
                  Text(
                    '記念日の設定',
                    style: theme.textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                      fontFamily: IFonts().kYomogi,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Icon(
                    Icons.edit,
                    size: 20,
                    color: Theme.of(context).disabledColor,
                  ),
                ],
              )
            : partner.anniversary == anniversary
                ? IgnorePointer(
                    ignoring: true,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          '記念日'
                          ' ${dateFormat.format(partner.anniversary!)}',
                          textStyle: theme.textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontFamily: IFonts().kYomogi,
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
                      onTap: null,
                    ),
                  )
                : Text(
                    '記念日'
                    ' ${dateFormat.format(anniversary!)}',
                    style: theme.textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.primaryColor,
                      fontFamily: IFonts().kYomogi,
                    ),
                  ),
      ),
    );
  }
}
