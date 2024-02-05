import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant/sabitler/color.dart';

class SbtTema {
  static var temam = ThemeData(
    iconTheme: IconThemeData(color: SbtColor.anaRenk),
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: SbtColor.anaRenk),
      actionsIconTheme: IconThemeData(color: SbtColor.anaRenk),
      titleTextStyle: GoogleFonts.dancingScript(
        textStyle: TextStyle(
            color: SbtColor.anaRenk, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: SbtColor.anaRenk,
      ),
    ),
    drawerTheme: const DrawerThemeData(shadowColor: Colors.red),
    scaffoldBackgroundColor: Colors.white,
  );
}
