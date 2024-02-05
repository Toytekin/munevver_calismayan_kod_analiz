import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../services/db_firebase.dart';
import '../model/post_model.dart';

// ignore: must_be_immutable
class BegeniButonum extends StatefulWidget {
  FirebaseDB db;
  List<PostModel> liste;
  int index;
  bool liked;
  String userID;
  BegeniButonum({
    super.key,
    required this.db,
    required this.index,
    required this.liked,
    required this.liste,
    required this.userID,
  });

  @override
  State<BegeniButonum> createState() => _BegeniButonumState();
}

class _BegeniButonumState extends State<BegeniButonum> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await widget.db
            .toggleBegeni(widget.liste[widget.index].postID, widget.userID);
        setState(() {});
      },
      icon: widget.liked
          ? FaIcon(FontAwesomeIcons.solidHeart, size: Get.width * 0.05)
          : FaIcon(FontAwesomeIcons.heart, size: Get.width * 0.05),
    );
  }
}
