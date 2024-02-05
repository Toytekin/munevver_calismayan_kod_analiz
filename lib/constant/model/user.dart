// ignore_for_file: constant_identifier_names

class UserModel {
  String userID;
  String userName;
  String userMail;
  String photoUrl;
  String yazarSeviyesi;

  UserModel({
    required this.userID,
    this.userName = '',
    required this.userMail,
    this.photoUrl = '',
    this.yazarSeviyesi = Seviyeler.CAYLAK,
  });

  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      "userName": userName,
      "userMail": userMail,
      "photoUrl": photoUrl,
      "yazarSeviyesi": yazarSeviyesi,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        userName = map['userName'],
        userMail = map['userMail'],
        photoUrl = map['photoUrl'],
        yazarSeviyesi = map['yazarSeviyesi'];
}

class Seviyeler {
  static const CAYLAK = 'ÇAYLAK';
  static const OKUR = 'OKUR';
  static const YAZAR = 'YAZAR';
  static const UZMAN = 'UZMAN';
}
