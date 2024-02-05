// ignore: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sosyal_app_munevver/a_sayfalar/home/anasayaf.dart';
import 'package:sosyal_app_munevver/a_sayfalar/post/post_textfild.dart';
import 'package:sosyal_app_munevver/constant/sabitler/color.dart';
import 'package:sosyal_app_munevver/constant/widget/textfild.dart';
import 'package:uuid/uuid.dart';

import '../../constant/model/post_model.dart';
import '../../constant/model/user.dart';
import '../../constant/widget/buton.dart';
import '../../services/db_firebase.dart';
import 'baslik.dart';
import 'etiketler.dart';
import 'p_provider_copy.dart';

// ignore: must_be_immutable
class PostPaylasmaScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  UserModel user;
  PostPaylasmaScreen({super.key, required this.user});

  @override
  State<PostPaylasmaScreen> createState() => _PostPaylasmaScreenState();
}

class _PostPaylasmaScreenState extends State<PostPaylasmaScreen> {
  var postController = TextEditingController();
  var baslikController = TextEditingController();
  var yeniEtiiketController = TextEditingController();

  Timestamp tarih = Timestamp.now();
  bool butonaTiklama = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderEtiket>(context);
    var db = Provider.of<FirebaseDB>(context);

    return Scaffold(
      appBar: AppBar(
        title: const SabitPostEtiketler(),
        actions: [
          butonaTiklama
              ? const CircularProgressIndicator()
              : SbtButon(
                  label: 'Paylaş',
                  press: () async {
                    if (baslikController.text.isNotEmpty &&
                        postController.text.isNotEmpty) {
                      butonaTiklama = true;
                      setState(() {});
                      var postID = const Uuid().v1();
                      // ignore: unused_local_variable
                      var post = PostModel(
                          userID: widget.user.userID,
                          postID: postID,
                          postBaslik: baslikController.text.toString(),
                          postYazi: postController.text.toString(),
                          olusturmaTarihi: tarih,
                          etiket: provider.eklenenEtiketler,
                          userPhotos: widget.user.photoUrl,
                          begeniSayisi: 0,
                          begenenUserIDleri: [],
                          yorumlar: []);

                      await db.postPaylas(post);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Anasayfa(user: widget.user),
                      ));
                    } else {}
                  },
                )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              PostTextFldBaslik(controller: baslikController),
              PostTextFld(controller: postController),
              const SabitPostEtiketler(),
              SizedBox(height: Get.height * 0.1),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: SbtColor.anaRenk,
        mini: true,
        disabledElevation: 0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Yeni Etikek'),
              actions: [
                SbtTextField(
                    controller: yeniEtiiketController, hintText: 'Etiiket'),
                ElevatedButton(
                    onPressed: () {
                      // ignore: unnecessary_null_comparison
                      if (yeniEtiiketController.text != null &&
                          yeniEtiiketController.text != '' &&
                          // ignore: unnecessary_null_comparison
                          yeniEtiiketController != null) {
                        provider.etiketEkleString(
                            yeniEtiiketController.text.toString());
                        yeniEtiiketController.clear();
                        Navigator.of(context).pop();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Ekle'))
              ],
            ),
          );
        },
        child: const Icon(Icons.new_label),
      ),
    );
  }
}
