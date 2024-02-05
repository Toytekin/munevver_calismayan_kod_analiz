import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';
import 'package:sosyal_app_munevver/constant/sabitler/color.dart';
import 'package:sosyal_app_munevver/constant/sabitler/text_style.dart';
import 'package:sosyal_app_munevver/services/firebase_servis.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constant/provider/usermodel_provider.dart';
import '../../constant/sabitler/resimyolu.dart';

class KayitEkrani extends StatefulWidget {
  const KayitEkrani({super.key});

  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  FirebaseServis sr = FirebaseServis();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool butonaTiklanmaDurumu = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserModelProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.1),
            munevver(),
            SizedBox(height: Get.height * 0.05),
            resim(),
            SizedBox(height: Get.height * 0.08),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  butonaTiklanmaDurumu == false
                      ? OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side:
                                BorderSide(width: 1.0, color: SbtColor.anaRenk),
                          ),
                          //////! //////////////
                          onPressed: () async {
                            butonaTiklanmaDurumu = true;
                            setState(() {});
                            UserModel? gelenUser = await sr.signwithGoogle();
                            user.setUser(gelenUser!);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Text('Google İle Giriş Yap'),
                          ))
                      : const CircularProgressIndicator(),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  Image resim() {
    return Image.asset(
      ImageConstants.instance.arkaPlan,
      width: Get.width * 0.7,
    );
  }

  Row munevver() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Münevver',
          style: SbtTextStyle.textfildBaslik,
        ),
        SizedBox(width: Get.width * 0.05),
        const FaIcon(FontAwesomeIcons.penClip)
      ],
    );
  }
}
