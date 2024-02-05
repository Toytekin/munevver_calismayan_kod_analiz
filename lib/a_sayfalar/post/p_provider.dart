import 'package:flutter/material.dart';

class ProviderEtiket with ChangeNotifier {
  List seciliEtiketler = [];

  void etEkle(int index) {
    if (seciliEtiketler.contains(index)) {
      debugPrint(seciliEtiketler.length.toString());
      seciliEtiketler.remove(index);
    } else {
      debugPrint(seciliEtiketler.length.toString());

      seciliEtiketler.add(index);
    }
    notifyListeners();
  }
}
