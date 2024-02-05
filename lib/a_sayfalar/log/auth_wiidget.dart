import 'package:flutter/material.dart';
import 'package:sosyal_app_munevver/a_sayfalar/home/anasayaf.dart';
import 'package:sosyal_app_munevver/a_sayfalar/log/error_page.dart';
import 'package:sosyal_app_munevver/a_sayfalar/log/login.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';

class AuthWidget extends StatelessWidget {
  final AsyncSnapshot<UserModel?> snapshot;
  const AuthWidget({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.active) {
      return snapshot.data != null
          ? Anasayfa(user: snapshot.data!)
          : const KayitEkrani();
    }
    return const ErrorPage();
  }
}
