// ignore: must_be_immutable
import 'package:flutter/material.dart';

import '../../constant/sabitler/text_style.dart';

// ignore: must_be_immutable
class SbtDraweRow extends StatelessWidget {
  Function() onpress;
  Icon icon;
  String yazi;
  SbtDraweRow({
    super.key,
    required this.onpress,
    required this.icon,
    required this.yazi,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onpress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            icon,
            Text(
              yazi,
              style: SbtTextStyle.tx2,
            ),
            Opacity(opacity: 0, child: icon),
          ],
        ),
      ),
    );
  }
}
