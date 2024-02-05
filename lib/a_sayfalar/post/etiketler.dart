// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../constant/sabitler/text_style.dart';
import 'p_provider_copy.dart';

// ignore: must_be_immutable
class SabitPostEtiketler extends StatefulWidget {
  const SabitPostEtiketler({
    super.key,
  });

  @override
  State<SabitPostEtiketler> createState() => _SabitPostEtiketlerState();
}

class _SabitPostEtiketlerState extends State<SabitPostEtiketler> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderEtiket>(context);
    return SizedBox(
      height: Get.width * 0.15,
      width: Get.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.eklenenEtiketler.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              provider.listedeAraVeSil(provider.eklenenEtiketler[index]);
            },
            child: Card(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    provider.eklenenEtiketler[index],
                    style: SbtTextStyle.miniStyle,
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
