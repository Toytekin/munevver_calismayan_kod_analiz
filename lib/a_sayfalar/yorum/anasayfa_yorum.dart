// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sosyal_app_munevver/a_sayfalar/home/anasayaf.dart';
import 'package:sosyal_app_munevver/constant/model/post_model.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';
import 'package:sosyal_app_munevver/constant/model/yorum_model.dart';
import 'package:sosyal_app_munevver/constant/sabitler/text_style.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../../services/db_firebase.dart';

// ignore: must_be_immutable
class YorumAnaSayfa extends StatefulWidget {
  UserModel userModel;
  PostModel postModel;
  YorumAnaSayfa({
    super.key,
    required this.postModel,
    required this.userModel,
  });

  @override
  State<YorumAnaSayfa> createState() => _YorumAnaSayfaState();
}

class _YorumAnaSayfaState extends State<YorumAnaSayfa> {
  Timestamp tarih = Timestamp.now();
  var yorumController = TextEditingController();

  List<YorumModel> siraliYorumlariAl(List<YorumModel> yorumlar) {
    yorumlar.sort((a, b) => b.yorumTarih.compareTo(a.yorumTarih));
    return yorumlar;
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirebaseDB>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yorumlar'),
      ),
      body: Center(
          child: Column(
        children: [
          //Yorumların Gözükeceği alan
          Expanded(
            flex: 7,
            child: widget.postModel.yorumlar != []
                ? ListView.builder(
                    itemCount: widget.postModel.yorumlar?.length,
                    itemBuilder: (context, index) {
                      var yorumlar = widget.postModel.yorumlar;

                      Timestamp timestamp = widget.postModel.olusturmaTarihi;

                      // Timestamp'i DateTime'e dönüştür
                      DateTime dateTime = timestamp.toDate();

                      // Tarihi gün/ay/yıl formatında göster
                      String formattedDate =
                          DateFormat('dd/MM/yyyy').format(dateTime);
                      if (yorumlar != null) {
                        var siraliYorumlar = siraliYorumlariAl(yorumlar);
                        var yorum = siraliYorumlar[index];
                        return Center(
                          child: Card(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    yorum.yorumyapanUserNaMe,
                                    style: SbtTextStyle.textfildBaslikMini,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(yorum.yorum),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(formattedDate),
                                ],
                              )
                            ],
                          )),
                        );
                      } else {
                        return const Text('Yorum Yapılmadı');
                      }
                    },
                  )
                : const Center(
                    child: Text('Yorum Yapılmadı'),
                  ),
          ),
          //!Yorum teextfild
          Expanded(
            flex: 1,
            child: Row(
              children: [
                TextFiieldYorum(),
                YorumButon(db, context),
              ],
            ),
          ),
        ],
      )),
    );
  }

  IconButton YorumButon(FirebaseDB db, BuildContext context) {
    return IconButton(
        onPressed: () async {
          var id = const Uuid().v1();

          if (yorumController.text.isNotEmpty &&
              yorumController.text.length > 20) {
            YorumModel yorumModel = YorumModel(
              yorumyapanUserID: widget.userModel.userID,
              yorumID: id,
              yorum: yorumController.text.toString(),
              yorumTarih: tarih,
              yorumyapanUserNaMe: widget.userModel.userName,
            );

            try {
              await db.yorumYap(yorumModel, widget.postModel.postID);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => Anasayfa(user: widget.userModel),
                  ),
                  (route) => true);
            } catch (e) {
              debugPrint(
                  'anasayfa_yorum sayfasında yorum yapma iconunda problem - $e');
            }
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content:
                      const Text('Yorumunuz en az 20 karakter içermelidir.'),
                  icon: const Icon(Icons.error),
                  title: const Text('Uyarı'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Tamam'),
                    ),
                  ],
                );
              },
            );
          }
        },
        icon: const Icon(Icons.send));
  }

  Expanded TextFiieldYorum() {
    return Expanded(
        child: TextField(
      maxLines: 3,
      controller: yorumController,
      decoration: const InputDecoration(hintText: 'Senin Yorumun Nedir?'),
    ));
  }
}



//! YAPILACAKLAR



// YORUM'a tıklandığında kişinin sayfası açılacak