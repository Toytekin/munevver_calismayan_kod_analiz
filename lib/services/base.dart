import 'package:sosyal_app_munevver/constant/model/user.dart';

abstract class BaseAuth {
  Future<UserModel?> signwithGoogle();
  Future<UserModel?> currentUser();
  Future<bool> signOut();
  Stream<UserModel> get userCahageState;
}
