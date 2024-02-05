import 'dart:io';

import 'package:sosyal_app_munevver/constant/model/user.dart';

import '../constant/model/post_model.dart';

abstract class BaseDB {
  Future<UserModel> userUpdate(UserModel userModel);
  Future<UserModel?> userCekkkk(String userId);
  Future<String?> resimcek();
  Future<String?> resimYukle(File file);
  Future<UserModel> yeniUser(UserModel userModel);
  Future<void> postPaylas(PostModel postModel);
  Future<void> toggleBegeni(String postID, String kullaniciID);
}
