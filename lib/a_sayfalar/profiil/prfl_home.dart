import 'package:flutter/material.dart';
import 'package:sosyal_app_munevver/a_sayfalar/profiil/prfl_post.dart';

import '../../constant/model/post_model.dart';

class ProfilHomeScreen extends StatefulWidget {
  const ProfilHomeScreen({super.key});

  @override
  State<ProfilHomeScreen> createState() => _ProfilHomeScreenState();
}

class _ProfilHomeScreenState extends State<ProfilHomeScreen> {
  List<PostModel> tumPostler = [];
  @override
  void initState() {
    super.initState();
    listeyiDoldur();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Home'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: tumPostler.length,
              itemBuilder: (context, index) {
                return SabitPostProfil(
                    postBaslik: tumPostler[index].postBaslik,
                    postString: tumPostler[index].postYazi,
                    likePress: () {},
                    paylasPress: () {},
                    yorumPress: () {},
                    deletePress: () {});
              },
            ))
          ],
        ),
      ),
    );
  }

  void listeyiDoldur() async {
    setState(() {});
  }
}

// void showAlertDialog(BuildContext context, PostDB db, PostModel postModel) {
//   // set up the buttons
//   Widget remindButton = TextButton(
//     child: const Text(
//       "Sil",
//       style: TextStyle(color: Colors.red),
//     ),
//     onPressed: () async {
//       await db.delete(postModel);
//       // ignore: use_build_context_synchronously
//       Navigator.of(context).pushAndRemoveUntil(
//           MaterialPageRoute(
//             builder: (context) => const ProfilHomeScreen(),
//           ),
//           (route) => false);
//     },
//   );
//   Widget cancelButton = TextButton(
//     child: const Text("Vazgeç"),
//     onPressed: () {
//       Navigator.of(context).pop();
//     },
//   );

//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: const Text("Uyarı"),
//     content: const Text("Paylaşımınız kalıcı olarak silinsin mi?"),
//     actions: [
//       remindButton,
//       cancelButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
