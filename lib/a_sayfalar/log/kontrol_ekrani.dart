import 'package:flutter/material.dart';
import 'package:sosyal_app_munevver/a_sayfalar/home/anasayaf.dart';
import 'package:sosyal_app_munevver/a_sayfalar/log/login.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';
import 'package:sosyal_app_munevver/services/base.dart';

class KontrolEkranii extends StatefulWidget {
  final BaseAuth baseAuth;
  const KontrolEkranii({
    super.key,
    required this.baseAuth,
  });

  @override
  State<KontrolEkranii> createState() => _KontrolEkraniiState();
}

class _KontrolEkraniiState extends State<KontrolEkranii> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    userKontrolEt();
  }

  @override
  Widget build(BuildContext context) {
    return user != null
        ? Anasayfa(
            user: user!,
          )
        : const KayitEkrani();
  }

  Future<void> userKontrolEt() async {
    var gelendeger = widget.baseAuth.currentUser();
    // ignore: unnecessary_null_comparison
    if (gelendeger != null) {
      var userim = await gelendeger;
      if (userim != null) {
        user = userim;
      } else {
        user = null;
      }
    } else {
      user = null;
    }
    setState(() {});
  }
}
