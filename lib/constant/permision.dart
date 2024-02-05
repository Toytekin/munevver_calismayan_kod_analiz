import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.camera,
    Permission.storage,
  ].request();

  if (statuses[Permission.photos] != PermissionStatus.granted) {
    // Kullanıcı kamera izinini vermedi
    // Burada kullanıcıya bir uyarı gösterebilir ve izin isteyebilirsiniz
  }

  if (statuses[Permission.storage] != PermissionStatus.granted) {
    // Kullanıcı depolama izinini vermedi
    // Burada kullanıcıya bir uyarı gösterebilir ve izin isteyebilirsiniz
  }
}
