import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sosyal_app_munevver/a_sayfalar/yorum/anasayfa_yorum.dart';
import 'package:sosyal_app_munevver/constant/model/post_model.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';
import 'package:sosyal_app_munevver/services/db_firebase.dart';
import '../../constant/sabitler/color.dart';
import '../../services/firebase_servis.dart';
import '../post/p_provider_copy.dart';
import '../post/post_home.dart';
import 'drawer_row.dart';

// ignore: must_be_immutable
class Anasayfa extends StatefulWidget {
  UserModel user;
  Anasayfa({super.key, required this.user});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

FirebaseServis auth = FirebaseServis();
bool cikis = false;
bool like = false;
int likeSayisi = 0;
UserModel gonderilecekUser = UserModel(userID: '', userMail: '');
FirebaseDB databes = FirebaseDB();

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
    userEslestir();
  }

  bool isLiked(String userID, List<String> begenenUserIDleri) {
    return begenenUserIDleri.contains(userID);
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<FirebaseDB>(context, listen: false);
    var provider = Provider.of<ProviderEtiket>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: SbtColor.anaRenk),
        title: appbarBaslik(),
        actions: [
          IconButton(
              onPressed: () {
                provider.eklenenEtiketler.clear();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PostPaylasmaScreen(user: gonderilecekUser),
                ));
              },
              icon: const FaIcon(FontAwesomeIcons.pencil))
        ],
      ),
      body: Center(
          child: FutureBuilder<List<PostModel>>(
        future: db.getAllPosts(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            List<PostModel>? liste = snapshot.data;
            return ListView.builder(
              itemCount: liste!.length,
              itemBuilder: (context, index) {
                bool liked =
                    isLiked(widget.user.userID, liste[index].begenenUserIDleri);
                var userPhoto = db.idIleResimCek(liste[index].userID);
                debugPrint(userPhoto.toString());
                PostModel postModel = liste[index];
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: dekor(),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: Get.width * 0.02),
                        child: Row(
                          children: [
                            ProfilResmi(db, liste, index),
                            SizedBox(width: Get.width * 0.1),
                            postBaslik(liste, index)
                          ],
                        ),
                      ),

                      SizedBox(width: Get.width * 0.1),
                      //! Post
                      Padding(
                        padding: EdgeInsets.all(Get.width * 0.02),
                        child: Text(liste[index].postYazi),
                      ),
                      SizedBox(width: Get.width * 0.1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            liste[index].begeniSayisi.toString(),
                            style: TextStyle(color: SbtColor.anaRenk),
                          ),
                          //! Beğeni Butonu
                          IconButton(
                            onPressed: () async {
                              await db.toggleBegeni(
                                  liste[index].postID, widget.user.userID);
                              setState(() {});
                            },
                            icon: liked
                                ? FaIcon(FontAwesomeIcons.solidHeart,
                                    size: Get.width * 0.05)
                                : FaIcon(FontAwesomeIcons.heart,
                                    size: Get.width * 0.05),
                          ),
                          //! Yorum Butonu

                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => YorumAnaSayfa(
                                      postModel: postModel,
                                      userModel: gonderilecekUser,
                                    ),
                                  ),
                                );
                              },
                              icon:
                                  Icon(Icons.message, size: Get.width * 0.06)),
                          //!
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      )),
      drawer: SabitDrawer(user: gonderilecekUser),
    );
  }

  // ignore: non_constant_identifier_names
  FutureBuilder<String> ProfilResmi(
      FirebaseDB db, List<PostModel> liste, int index) {
    return FutureBuilder(
      future: db.idIleResimCek(liste[index].userID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Bekleme göstergesi
        } else if (snapshot.hasError) {
          return Text('Hata: ${snapshot.error}');
        } else if (snapshot.hasData) {
          String userPhoto = snapshot.data.toString();
          return CircularProfileAvatar(
            '', // Avatar için bir anahtar (key)
            cacheImage: true,
            imageFit: BoxFit.cover,
            elevation: 1,
            onTap: () async {},
            radius: Get.height * 0.03,
            child: userPhoto.isNotEmpty
                ? Image.network(
                    userPhoto,
                    fit: BoxFit.cover,
                  )
                : const Icon(
                    Icons.person), // Varsa profil resmi, yoksa varsayılan ikon
          );
        } else {
          return const Icon(Icons.person); // Varsayılan ikon
        }
      },
    );
  }

  Text appbarBaslik() {
    return const Text(
      'Münevver',
      style: TextStyle(fontSize: 23),
    );
  }

  Text postBaslik(List<PostModel> liste, int index) =>
      Text(liste[index].postBaslik);

  BoxDecoration dekor() {
    return BoxDecoration(
      color: Colors.white, // Container arka plan rengi
      borderRadius: BorderRadius.circular(8.0), // Köşelerin yuvarlaklığı
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), // Gölge rengi
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3), // Gölgenin yönü (x, y)
        ),
      ],
    );
  }

  Future<void> userEslestir() async {
    var data = await databes.userCekkkk(widget.user.userID);
    if (data != null) {
      gonderilecekUser = data;
    } else {
      gonderilecekUser = widget.user;
    }
    setState(() {});
  }
}
