import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant/sabitler/color.dart';

// ignore: must_be_immutable
class PostTextFld extends StatelessWidget {
  TextEditingController controller;

  PostTextFld({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: controller,
        maxLength: 571,
        minLines: 20,
        maxLines: 25,
        decoration: InputDecoration(
          prefix: const FaIcon(FontAwesomeIcons.penClip, size: 20),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
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
