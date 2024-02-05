import 'package:flutter/material.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';

class UserModelProvider extends ChangeNotifier {
  UserModel _user = UserModel(userID: 'userID', userMail: 'userMail');

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
