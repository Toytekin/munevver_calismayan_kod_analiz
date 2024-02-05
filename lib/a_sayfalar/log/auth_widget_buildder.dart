import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sosyal_app_munevver/constant/model/user.dart';
import 'package:sosyal_app_munevver/services/firebase_servis.dart';

class AuthWidgetBuilder extends StatelessWidget {
  final Widget Function(
      BuildContext context, AsyncSnapshot<UserModel?> snapshot) onPageBuilder;
  const AuthWidgetBuilder({super.key, required this.onPageBuilder});

  @override
  Widget build(BuildContext context) {
    final autServis = Provider.of<FirebaseServis>(context, listen: false);
    return StreamBuilder<UserModel?>(
      stream: autServis.userCahageState,
      builder: (context, AsyncSnapshot<UserModel?> snapshot) {
        final userData = snapshot.data;
        if (userData != null) {
          return MultiProvider(
            providers: [
              Provider.value(value: userData),
            ],
            child: onPageBuilder(context, snapshot),
          );
        }
        return onPageBuilder(context, snapshot);
      },
    );
  }
}
