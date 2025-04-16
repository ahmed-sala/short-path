import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestStoragePermission() async {
  if (Platform.isAndroid) {
    // For Android 11 and above, request MANAGE_EXTERNAL_STORAGE permission.
    // Otherwise, request normal storage permission.
    // Note: You may need to adjust this logic if you want to handle specific API levels.
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    if (androidInfo.version.sdkInt >= 30) {
      // Request the manage external storage permission
      var status = await Permission.manageExternalStorage.status;
      if (!status.isGranted) {
        status = await Permission.manageExternalStorage.request();
      }
      return status.isGranted;
    } else {
      // For devices below Android 11, request normal storage permission.
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    }
  } else {
    // For non-Android platforms, assume permission is granted.
    return true;
  }
}
