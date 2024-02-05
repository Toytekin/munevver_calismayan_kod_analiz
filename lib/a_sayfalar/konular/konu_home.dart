import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sosyal_app_munevver/a_sayfalar/home/anasayaf.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';

import '../../constant/sabitler/text_style.dart';

// ignore: must_be_immutable
class KonularHomeScreen extends StatefulWidget {
  UserModel user;
  KonularHomeScreen({super.key, required this.user});

  @override
  State<KonularHomeScreen> createState() => _KonularHomeScreenState();
}

class _KonularHomeScreenState extends State<KonularHomeScreen> {
  final _konular = [
    'Gündem',
    'Haber',
    'Teknoloji',
    'Spor',
    'Siyaset',
    'Ekonomi',
    'Oyunlar',
    'Dini',
  ];

  final double _iconSize = Get.width / 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konular'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Anasayfa(user: widget.user),
                ));
              },
              icon: const Icon(
                Icons.home,
              ))
        ],
      ),
      body: SafeArea(
          child: GridView.builder(
        itemCount: _konular.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      _konular[index],
                      style: SbtTextStyle.tx3,
                    ),
                  ),
                ),
                Expanded(
                    child: Center(
                  child: iconGetir(index),
                ))
              ],
            ),
          );
        },
      )),
    );
  }

  iconGetir(int index) {
    switch (index) {
      case 0:
        return FaIcon(FontAwesomeIcons.calendarDay, size: _iconSize);
      case 1:
        return FaIcon(FontAwesomeIcons.adversal, size: _iconSize);
      case 2:
        return FaIcon(FontAwesomeIcons.computerMouse, size: _iconSize);
      case 3:
        return FaIcon(FontAwesomeIcons.futbol, size: _iconSize);
      case 4:
        return FaIcon(FontAwesomeIcons.microphone, size: _iconSize);
      case 5:
        return FaIcon(FontAwesomeIcons.moneyCheckDollar, size: _iconSize);
      case 6:
        return FaIcon(FontAwesomeIcons.gamepad, size: _iconSize);
      case 7:
        return FaIcon(FontAwesomeIcons.mosque, size: _iconSize);
      case 8:
        return FaIcon(FontAwesomeIcons.moneyCheckDollar, size: _iconSize);
      case 9:
        return FaIcon(FontAwesomeIcons.moneyCheckDollar, size: _iconSize);

      default:
        return FaIcon(FontAwesomeIcons.pencil, size: _iconSize);
    }
  }
}
