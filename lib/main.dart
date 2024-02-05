import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sosyal_app_munevver/a_sayfalar/log/auth_widget_buildder.dart';
import 'package:sosyal_app_munevver/a_sayfalar/log/auth_wiidget.dart';
import 'package:sosyal_app_munevver/constant/provider/begeni.dart';
import 'package:sosyal_app_munevver/constant/provider/usermodel_provider.dart';
import 'package:sosyal_app_munevver/services/firebase_servis.dart';
import 'package:sosyal_app_munevver/services/db_firebase.dart';
import 'package:sosyal_app_munevver/theme/theme.dart';

import 'a_sayfalar/post/p_provider_copy.dart';
import 'constant/permision.dart';

Future<void> main() async {
  // İİZİN SAYFASINA YÖNLENDİRME
// Fİrebase ayarlarının olduğu alan

  WidgetsFlutterBinding.ensureInitialized();
  requestPermissions();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<PrBegeniKontrol>(
              create: (context) => PrBegeniKontrol()),
          ChangeNotifierProvider<ProviderEtiket>(
              create: (context) => ProviderEtiket()),
          ChangeNotifierProvider<UserModelProvider>(
              create: (context) => UserModelProvider()),
          Provider<FirebaseDB>(create: (_) => FirebaseDB()),
          Provider<FirebaseServis>(create: (context) => FirebaseServis()),
        ],
        child: AuthWidgetBuilder(
          onPageBuilder: (context, snapshot) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: SbtTema.temam,
            home: AuthWidget(snapshot: snapshot),
          ),
        ));
  }
}



  //  Platform  Firebase App Id
  //  web       1:222373362005:web:46d7f4b2d8dce73dafd7dc
  //   android   1:222373362005:android:b1e62958b026bec1afd7dc
  //  ios       1:222373362005:ios:6c3325dfc087e256afd7dc
  //  macos     1:222373362005:ios:6c3325dfc087e256afd7dc


  //! GENEL NOTLAR
  //? Postlar geldiiğinde ilgili kiişinin güncel profiil resmini ayarla
  //? Yorumlar kısmını ayarla
  //*  Google ile giriş ios için yapılandırmadın
  //! BEĞENİ TUŞUNA BASINSA SAYFA KOMPLE YENİLENMESİN
