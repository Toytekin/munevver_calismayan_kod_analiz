import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/sabitler/text_style.dart';

// ignore: must_be_immutable
class SabitPostProfil extends StatelessWidget {
  String postBaslik;

  String postString;
  Function() likePress;
  Function() paylasPress;
  Function() yorumPress;
  Function() deletePress;

  SabitPostProfil({
    super.key,
    required this.postBaslik,
    required this.postString,
    required this.likePress,
    required this.paylasPress,
    required this.yorumPress,
    required this.deletePress,
  });

  @override
  Widget build(BuildContext context) {
    const double iconSize = 18;
    return SizedBox(
      width: Get.width,
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    postBaslik,
                    style: SbtTextStyle.textfildBaslikMini,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                postString,
                style: SbtTextStyle.midiumStyle,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: paylasPress,
                    icon: const Icon(Icons.share, size: iconSize)),
                IconButton(
                    onPressed: yorumPress,
                    icon: const Icon(Icons.message, size: iconSize)),
                IconButton(
                    onPressed: likePress,
                    icon: const Icon(Icons.favorite_sharp, size: iconSize)),
                IconButton(
                    onPressed: deletePress,
                    icon: const Icon(
                      Icons.delete,
                      size: iconSize,
                      color: Colors.red,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
