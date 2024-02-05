import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sosyal_app_munevver/a_sayfalar/ayarlar/ayarlar_home.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';
import 'package:sosyal_app_munevver/constant/sabitler/text_style.dart';
import '../../constant/sabitler/resimyolu.dart';
import '../../services/firebase_servis.dart';
import '../konular/konu_home.dart';
import '../profiil/prfl_home.dart';
import 'drawer.dart';

// ignore: must_be_immutable
class SabitDrawer extends StatefulWidget {
  UserModel user;
  SabitDrawer({super.key, required this.user});

  @override
  State<SabitDrawer> createState() => _SabitDrawerState();
}

class _SabitDrawerState extends State<SabitDrawer> {
  final geciciResim = 'assets/image/ron.jpg';

  FirebaseServis dbUser = FirebaseServis();

  @override
  Widget build(BuildContext context) {
    var resimUrl = widget.user.photoUrl;
    return Drawer(
      width: Get.width / 2,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                SizedBox(height: Get.height * 0.05),
                CircularProfileAvatar(
                  '',
                  cacheImage: true,
                  imageFit: BoxFit.cover,
                  elevation: 10,
                  onTap: () async {},
                  radius: Get.height * 0.06,
                  // ignore: unnecessary_null_comparison
                  child: resimUrl != ''
                      ? Image.network(
                          resimUrl,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          ImageConstants.instance.login,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(height: Get.width * 0.08),
                SbtDraweRow(
                    onpress: () => profilSayfasi(context),
                    icon: const Icon(Icons.person, color: Colors.black),
                    yazi: 'Profil'),
                SbtDraweRow(
                    onpress: () => konularSayfasi(context, widget.user),
                    icon: const Icon(Icons.pending, color: Colors.black),
                    yazi: 'Konular'),
                SbtDraweRow(
                    onpress: () {},
                    icon: const Icon(Icons.favorite_sharp, color: Colors.black),
                    yazi: 'Beğeniler'),
                SbtDraweRow(
                    onpress: () {},
                    icon: const Icon(Icons.message, color: Colors.black),
                    yazi: 'Mesajlar'),
              ],
            )),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SbtDraweRow(
                      onpress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AyarlarHome(user: widget.user),
                            ));
                      },
                      icon: const Icon(Icons.settings, color: Colors.black),
                      yazi: 'Ayarlar'),
                  Cikis(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  SbtDraweRow Cikis(BuildContext context) {
    return SbtDraweRow(
        onpress: () async {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'Uyarı',
                style: SbtTextStyle.textfildBaslik,
              ),
              content: const Text('Uygulamadan çıkmak istediğine emin misin?'),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent),
                    onPressed: () async {
                      await dbUser.signOut();
                    },
                    child: const Text('Evet')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Vazgeç'))
              ],
            ),
          );
        },
        icon: const Icon(Icons.exit_to_app, color: Colors.black),
        yazi: 'Çıkış');
  }
}

konularSayfasi(BuildContext context, UserModel user) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => KonularHomeScreen(
      user: user,
    ),
  ));
}

profilSayfasi(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => const ProfilHomeScreen(),
  ));
}
