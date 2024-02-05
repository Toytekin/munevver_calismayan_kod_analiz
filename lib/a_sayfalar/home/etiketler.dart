import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/sabitler/text_style.dart';

// ignore: must_be_immutable
class SabitEtiketler extends StatelessWidget {
  List<String> liste;
  SabitEtiketler({
    super.key,
    required this.liste,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.15,
      width: Get.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: liste.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              debugPrint(liste[index]);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      liste[index],
                      style: SbtTextStyle.miniStyle,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
