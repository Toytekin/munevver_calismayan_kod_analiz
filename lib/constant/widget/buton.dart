import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sabitler/color.dart';
import '../sabitler/text_style.dart';

// ignore: must_be_immutable
class SbtButon extends StatelessWidget {
  String label;
  Function() press;
  SbtButon({super.key, required this.label, required this.press});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
          maximumSize: Size(Get.width / 4, 5),
          minimumSize: Size(Get.width / 5, 4),
          backgroundColor: Colors.white,
          shape: StadiumBorder(side: BorderSide(color: SbtColor.anaRenk)),
        ),
        child: Text(label, style: SbtTextStyle.miniStyle),
      ),
    );
  }
}
