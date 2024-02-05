import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant/sabitler/color.dart';
import '../../constant/sabitler/text_style.dart';

// ignore: must_be_immutable
class PostTextFldBaslik extends StatelessWidget {
  TextEditingController controller;

  PostTextFldBaslik({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextField(
        style: SbtTextStyle.textfildBaslik,
        controller: controller,
        maxLength: 20,
        decoration: InputDecoration(
          label: const Text('Başlık'),
          prefix: const FaIcon(FontAwesomeIcons.penClip, size: 15),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(1))),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SbtColor.anaRenk),
            borderRadius: const BorderRadius.all(
              Radius.circular(16),
            ),
          ),
        ),
      ),
    );
  }
}
