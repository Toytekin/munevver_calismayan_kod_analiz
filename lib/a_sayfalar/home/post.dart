import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/sabitler/resimyolu.dart';
import '../../constant/sabitler/text_style.dart';

// ignore: must_be_immutable
class SabitPost extends StatelessWidget {
  String postBaslik;

  String postString;
  Function() likePress;
  Function() paylasPress;
  Function() yorumPress;
  bool likebool;

  SabitPost({
    super.key,
    required this.postBaslik,
    required this.postString,
    required this.likePress,
    required this.paylasPress,
    required this.yorumPress,
    this.likebool = false,
  });

  @override
  Widget build(BuildContext context) {
    const double iconSize = 18;
    return SizedBox(
      width: Get.width,
      child: Card(
        elevation: 5,
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
                    icon: const Icon(
                      Icons.share,
                      size: iconSize,
                    )),
                IconButton(
                    onPressed: yorumPress,
                    icon: const Icon(
                      Icons.message,
                      size: iconSize,
                    )),
                IconButton(
                    onPressed: likePress,
                    icon: Image.asset(
                      likebool == false
                          ? ImageConstants.instance.likeBos
                          : ImageConstants.instance.likeDolu,
                      height: 20,
                      width: 20,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
