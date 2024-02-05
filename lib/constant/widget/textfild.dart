import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../sabitler/color.dart';

// ignore: must_be_immutable
class SbtTextField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  bool redBorder;

  SbtTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.redBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          maxLength: 20,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: redBorder == true
                ? const TextStyle(color: Colors.red)
                : const TextStyle(color: Colors.grey),
            prefix: const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: FaIcon(FontAwesomeIcons.penClip, size: 10),
            ),
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
      ),
    );
  }
}
