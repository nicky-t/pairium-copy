import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockTimer extends StatefulWidget {
  const ClockTimer({
    this.timeTextStyle,
    this.dateTextStyle,
    this.secondsTextStyle,
    Key? key,
  }) : super(key: key);

  final TextStyle? timeTextStyle;
  final TextStyle? dateTextStyle;
  final TextStyle? secondsTextStyle;

  @override
  _ClockTimerState createState() => _ClockTimerState();
}

class _ClockTimerState extends State<ClockTimer> {
  String _date = '';
  String _time = '';
  String _seconds = '';

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), _onTimer);
  }

  void _onTimer(Timer timer) {
    final timeFormat = DateFormat.Hm('ja');
    final dateFormat = DateFormat.yMMMEd('ja');
    final secondFormat = DateFormat.s('ja');
    final now = DateTime.now();

    setState(() {
      _time = timeFormat.format(now);
      _seconds = secondFormat.format(now);
      _date = dateFormat.format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: const AlignmentDirectional(0.38, 0.5),
          children: [
            Center(
              child: Text(
                _time,
                style: widget.timeTextStyle ??
                    Theme.of(context).textTheme.headline4,
              ),
            ),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryVariant,
              maxRadius: 12,
              child: Text(
                _seconds,
                style: widget.secondsTextStyle ??
                    Theme.of(context).textTheme.caption,
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        Text(
          _date,
          style: widget.dateTextStyle ?? Theme.of(context).textTheme.subtitle1,
        ),
      ],
    );
  }
}
