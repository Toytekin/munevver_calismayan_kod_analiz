import 'package:flutter/material.dart';
import 'package:sosyal_app_munevver/constant/model/post_model.dart';

class PrBegeniKontrol extends ChangeNotifier {
  int begeniSayisi = 0;
  bool begeniDurum = false;
  List<PostModel> allPosts = <PostModel>[];

  void verileriCek(List<PostModel> allPostList) {
    allPosts = allPostList;
    notifyListeners();
  }

  void begeniArttirAzalt() {
    if (begeniDurum == false) {
      begeniDurum = true;
      begeniSayisi = begeniSayisi + 1;
      notifyListeners();
    } else {
      begeniDurum = false;
      begeniSayisi = begeniSayisi - 1;
      notifyListeners();
    }
  }
}
