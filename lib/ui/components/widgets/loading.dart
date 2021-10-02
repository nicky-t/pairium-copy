import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset('assets/loading-book.json',
              repeat: true, width: screenSize.width / 2, fit: BoxFit.fill),
          Positioned(
            bottom: 16,
            child: Text(
              'loading',
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: Colors.white,
                    fontFamily: IFonts().kAppTitle,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextLoading extends StatelessWidget {
  const TextLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Center(
      child: Lottie.asset('assets/loading-text-animation.json',
          repeat: true, width: screenSize.width / 2),
    );
  }
}
