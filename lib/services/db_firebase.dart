// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:sosyal_app_munevver/constant/model/post_model.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';
import 'package:sosyal_app_munevver/constant/model/yorum_model.dart';
import 'package:sosyal_app_munevver/services/base_db.dart';

class FirebaseDB extends BaseDB {
  final String baseFotoUrl =
      'https://firebasestorage.googleapis.com/v0/b/sendedinle-3c8e9.appspot.com/o/snededinle%2Fsendedinle.jpeg?alt=media&token=b9858767-31d2-4545-8fcd-b64c5ae16d47';

  final FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  //?* POST DATABASE İŞLEMLERİ
  @override
  Future<void> postPaylas(PostModel postModel) async {
    try {
      await db.collection('posts').doc(postModel.postID).set(postModel.toMap());
    } catch (e) {
      print('--postPaylas-- hatası$e');
    }
  }

  @override
  Future<String?> resimYukle(File file) async {
    var yol = firebaseStorage
        .ref()
        .child('profilResmi')
        .child(firebaseAuth.currentUser!.uid)
        .child('profilResmi.png');

    await yol.putFile(file);
    String url = await yol.getDownloadURL();
    return url;
  }

  @override
  Future<String?> resimcek() async {
    var yol = firebaseStorage
        .ref()
        .child('profilResmi')
        .child(firebaseAuth.currentUser!.uid)
        .child('profilResmi.png');

    try {
      String url = await yol.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }

//? BEĞENME DURUMUJNU ANLIK DİNLEME

  @override
  Future<void> toggleBegeni(String postID, String kullaniciID) async {
    try {
      await FirebaseFirestore.instance
          .runTransaction((Transaction transaction) async {
        DocumentReference postRef =
            FirebaseFirestore.instance.collection('posts').doc(postID);

        DocumentSnapshot postSnapshot = await transaction.get(postRef);

        if (postSnapshot.exists) {
          Map<String, dynamic> postData =
              postSnapshot.data() as Map<String, dynamic>;

          if ((postData['begenenUserIDleri'] as List<dynamic>)
              .contains(kullaniciID)) {
            // Kullanıcı daha önce beğeni yapmışsa, beğeni sayısını azalt ve kullanıcıyı çıkar
            transaction.update(postRef, {
              'begeniSayisi': postData['begeniSayisi'] - 1,
              'begenenUserIDleri': FieldValue.arrayRemove([kullaniciID])
            });
          } else {
            // Kullanıcı daha önce beğeni yapmamışsa, beğeni sayısını artır ve kullanıcıyı ekle
            transaction.update(postRef, {
              'begeniSayisi': postData['begeniSayisi'] + 1,
              'begenenUserIDleri': FieldValue.arrayUnion([kullaniciID])
            });
          }
        } else {
          print('Post ID bulunamadı: $postID');
        }
      });
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }

  @override
  Future<UserModel?> userCekkkk(String userId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await FirebaseFirestore.instance.collection('user').doc(userId).get();

      if (documentSnapshot.exists) {
        // Kullanıcı var, verileri al
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        UserModel user = UserModel.fromMap(data);
        return user;
      } else {
        // Kullanıcı yok
        return null;
      }
    } catch (e) {
      print('Hata: $e');
      return null;
    }
  }

  @override
  Future<UserModel> userUpdate(UserModel userModel) async {
    try {
      await db.collection('user').doc(userModel.userID).set(userModel.toMap());
      var data = await db.collection('users').doc(userModel.userID).get();
      var mapdata = data.data();
      var usermodel = UserModel.fromMap(mapdata!);
      return usermodel;
    } catch (e) {
      // ignore:
      print('Olmadı Hata iştye bu----------- $e');
      return userModel;
    }
  }

  @override
  Future<UserModel> yeniUser(UserModel userModel) async {
    var gelenData = await db.collection('user').doc(userModel.userID).get();
    var mapData = gelenData.data();

    if (mapData != null) {
      var data = UserModel(
          userID: userModel.userID,
          userName: userModel.userName,
          userMail: userModel.userMail,
          photoUrl: mapData["photoUrl"] ?? baseFotoUrl,
          yazarSeviyesi: userModel.yazarSeviyesi);
      return data;
    } else {
      return userModel;
    }
  }

  Future<String> idIleResimCek(String userID) async {
    var yol = firebaseStorage
        .ref()
        .child('profilResmi')
        .child(userID)
        .child('profilResmi.png');

    try {
      String url = await yol.getDownloadURL();

      return url;
    } catch (e) {
      return baseFotoUrl;
    }
  }

  Future<UserModel?> getUserWithID(String userID) async {
    try {
      var gelenData = await db.collection('user').doc(userID).get();
      var mapData = gelenData.data();

      var data = UserModel(
          userID: mapData!["userID"],
          userName: mapData["userName"],
          userMail: mapData["userMail"],
          photoUrl: mapData["photoUrl"] ?? baseFotoUrl,
          yazarSeviyesi: mapData["yazarSeviyesi"]);
      return data;
    } catch (e) {
      print('---getUserWithID --- de hata var ---$e');
      return null;
    }
  }

  Future<List<PostModel>> getAllPosts() async {
    List<PostModel> posts = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('posts')
          .orderBy('olusturmaTarihi',
              descending:
                  true) // Tarihe göre azalan sıralama (en yeni en üstte)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        PostModel post = PostModel.fromMap(data);
        posts.add(post);
      }
    } catch (e) {
      print('Veri çekme hatası: $e');
    }

    return posts;
  }

//Yorum yapma

  Future<void> yorumYap(YorumModel yorumModel, String postID) async {
    CollectionReference postCollection =
        FirebaseFirestore.instance.collection('posts');
    await postCollection.doc(postID).update({
      'yorumlar': FieldValue.arrayUnion([yorumModel.toMap()]),
    });
  }
}
