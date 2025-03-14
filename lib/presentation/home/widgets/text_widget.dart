import 'package:flutter/material.dart';
import 'package:techzeramt/core/constants/app_colors.dart';

class Textwidget extends StatelessWidget {
  const Textwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text.rich(
      TextSpan(children: [
        TextSpan(
            text: 'Use and Feel the',
            style: TextStyle(
                color: kWhite, fontSize: 35, fontWeight: FontWeight.bold)),
        TextSpan(
            text: '  Difference',
            style: TextStyle(
                color: kDeepOrange, fontSize: 45, fontWeight: FontWeight.bold))
      ]),
      textAlign: TextAlign.center,
    );
  }
}
