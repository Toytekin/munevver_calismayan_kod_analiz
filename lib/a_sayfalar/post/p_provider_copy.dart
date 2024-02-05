import 'package:flutter/material.dart';

class ProviderEtiket with ChangeNotifier {
  List seciliEtiketler = [];
  List<String> eklenenEtiketler = [];

  void listedeAraVeSil(String aranacakEtiket) {
    // Silinecek öğeleri belirle
    List<String> silinecekler = [];

    for (String etiket in eklenenEtiketler) {
      if (etiket.contains(aranacakEtiket)) {
        silinecekler.add(etiket);
      }
    }

    // Belirlenen öğeleri listeden kaldır
    for (String silinecek in silinecekler) {
      eklenenEtiketler.remove(silinecek);
    }

    // Değişiklikleri bildir
    notifyListeners();
  }

  void etiketEkleString(String etiket) {
    eklenenEtiketler.add(etiket);
    notifyListeners();
  }
}
