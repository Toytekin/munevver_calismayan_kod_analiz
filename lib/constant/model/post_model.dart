import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sosyal_app_munevver/constant/model/yorum_model.dart';

class PostModel {
  String userID;
  String postID;
  String postBaslik;
  String postYazi;
  String userPhotos;
  Timestamp olusturmaTarihi;
  int begeniSayisi;
  List<String> etiket;
  List<String> begenenUserIDleri;

  List<YorumModel>? yorumlar;

  // EKLENECEKLER
  //? String etiketler

  PostModel(
      {required this.userID,
      required this.postID,
      required this.postBaslik,
      required this.postYazi,
      required this.begenenUserIDleri,
      required this.olusturmaTarihi,
      this.begeniSayisi = 0,
      required this.yorumlar,
      required this.etiket,
      required this.userPhotos});

  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      "postID": postID,
      "userPhotos": userPhotos,
      "postBaslik": postBaslik,
      "postYazi": postYazi,
      "olusturmaTarihi": olusturmaTarihi,
      "begeniSayisi": begeniSayisi,
      "etiket": etiket,
      "begenenUserIDleri": begenenUserIDleri,
      "yorumlar":
          yorumlar != null ? yorumlar!.map((e) => e.toMap()).toList() : []
    };
  }

  PostModel.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        postID = map['postID'],
        postBaslik = map['postBaslik'],
        postYazi = map['postYazi'],
        userPhotos = map['userPhotos'],
        olusturmaTarihi = map['olusturmaTarihi'],
        begeniSayisi = map["begeniSayisi"],
        etiket = (map["etiket"] != null)
            ? List<String>.from(map["etiket"])
            : [], // List<String> oluşturarak dönüşüm sağla
        begenenUserIDleri = (map["begenenUserIDleri"] != null)
            ? List<String>.from(map["begenenUserIDleri"])
            : [], // List<String> oluşturarak dönüşüm sağla
        yorumlar = (map["yorumlar"] != null)
            ? (map["yorumlar"] as List<dynamic>)
                .map((item) => YorumModel.fromMap(item))
                .toList()
            : []; // List<YorumModel> oluşturarak dönüşüm sağla
}
