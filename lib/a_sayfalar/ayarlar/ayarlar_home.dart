import 'dart:io';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sosyal_app_munevver/a_sayfalar/home/anasayaf.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';
import 'package:sosyal_app_munevver/constant/sabitler/resimyolu.dart';
import 'package:sosyal_app_munevver/constant/widget/textfild.dart';
import '../../services/db_firebase.dart';

// ignore: must_be_immutable
class AyarlarHome extends StatefulWidget {
  UserModel user;
  AyarlarHome({super.key, required this.user});

  @override
  State<AyarlarHome> createState() => _AyarlarHomeState();
}

class _AyarlarHomeState extends State<AyarlarHome> {
  // RESİM  ALMNA

  ImagePicker imagePicker = ImagePicker();
  File? dosya;

  // ignore: prefer_typing_uninitialized_variables
  var resimIndirmeBaglantisi;
  UserModel? userModel;

//  String userID;
  var ad = TextEditingController();
  FirebaseDB databes = FirebaseDB();
  bool butonaTiklama = false;
  @override
  void initState() {
    super.initState();
    ad.text = widget.user.userName;
    butonaTiklama = false;
    resimKontrol();
  }

  resimKontrol() async {
    var photoDB = Provider.of<FirebaseDB>(context, listen: false);
    userModel = await FirebaseDB().yeniUser(widget.user);

    resimIndirmeBaglantisi = await photoDB.resimcek();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirebaseDB>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.userName),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ProfilResmi(),
            // ignore: unnecessary_null_comparison
            widget.user.userName == ''
                ? SbtTextField(
                    controller: ad,
                    hintText: 'Adınız',
                    redBorder: true,
                  )
                : SbtTextField(controller: ad, hintText: widget.user.userName),
            Mail(),
            Seviye(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                butonaTiklama == false
                    ? ElevatedButton(
                        onPressed: () async {
                          butonaTiklama = true;
                          setState(() {});
                          String? resilink;

                          /// Güncel USER Bilgilertini alma
                          if (dosya != null) {
                            resilink = await db.resimYukle(dosya!);
                          }

                          ///
                          UserModel guncelUser = UserModel(
                            userID: widget.user.userID,
                            userMail: widget.user.userMail,
                            photoUrl: resilink ?? '',
                            userName: ad.text.toString(),
                            yazarSeviyesi: widget.user.yazarSeviyesi,
                          );
                          // VERİ TABANI İŞLEMLERİ
                          await db.userUpdate(guncelUser);

                          // sayfaya yönlendirme
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) =>
                                    Anasayfa(user: guncelUser),
                              ),
                              (route) => false);
                        },
                        child: const Text('Kaydet'))
                    : const CircularProgressIndicator(),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  CircularProfileAvatar ProfilResmi() {
    return CircularProfileAvatar(
      '',
      cacheImage: true,
      imageFit: BoxFit.cover,
      borderWidth: 2,
      elevation: 10,
      onTap: () async {
        picImage();
      },
      radius: 50,
      child: dosya != null
          ? Image.file(dosya!, fit: BoxFit.cover)
          : resimIndirmeBaglantisi != null
              ? Image.network(
                  resimIndirmeBaglantisi!,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  ImageConstants.instance.login,
                  fit: BoxFit.cover,
                ),
    );
  }

  // ignore: non_constant_identifier_names
  Card Seviye() {
    return Card(
      child: ListTile(
        title: const Text('Yazarlık Seviyem'),
        subtitle: Text(widget.user.yazarSeviyesi),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Card Mail() {
    return Card(
      child: ListTile(
        title: const Text('Mail'),
        subtitle: Text(widget.user.userMail),
      ),
    );
  }

  Future<void> picImage() async {
    var photo = await imagePicker.pickImage(source: ImageSource.gallery);

    if (photo != null) {
      setState(() {
        dosya = File(photo.path);
      });
    } else {
      return;
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Beklenmedik Bir hata oluştu'),
      ),
    );
  }
}
