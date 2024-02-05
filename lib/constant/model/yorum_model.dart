import 'package:cloud_firestore/cloud_firestore.dart';

class YorumModel {
  String yorumyapanUserID;
  String yorumyapanUserNaMe;

  String yorumID;
  String yorum;
  Timestamp yorumTarih;

  YorumModel({
    required this.yorumyapanUserID,
    required this.yorumyapanUserNaMe,
    required this.yorumID,
    required this.yorum,
    required this.yorumTarih,
  });

  Map<String, dynamic> toMap() {
    return {
      "yorumyapanUserID": yorumyapanUserID,
      "yorumyapanUserNaMe": yorumyapanUserNaMe,
      "yorumID": yorumID,
      "yorum": yorum,
      "yorumTarih": yorumTarih,
    };
  }

  YorumModel.fromMap(Map<String, dynamic> map)
      : yorumyapanUserID = map['yorumyapanUserID'],
        yorumID = map['yorumID'],
        yorumyapanUserNaMe = map['yorumyapanUserNaMe'],
        yorum = map['yorum'],
        yorumTarih = map['yorumTarih'];
}
