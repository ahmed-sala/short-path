import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/core/extensions/extensions.dart';

import '../../../../../../core/common/common_imports.dart';
import '../../../../../../core/functions/storage_permission.dart';
import '../cv_screen.dart';

Future<void> handleCreateCV(
  BuildContext context, {
  String? jobDescription,
  int? jobId,
}) async {
  // First check if permission is already granted.
  bool alreadyGranted = await hasStoragePermission();
  if (alreadyGranted) {
    Fluttertoast.showToast(
      msg: context.localization.permissionAlreadyGrantedDownloadingFile,
      backgroundColor: Colors.green,
    );
    // Navigate to CvScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CvScreen(
          jobDescription: jobDescription,
          jobId: jobId,
        ),
      ),
    );
    return;
  }

  // If not, show a dialog asking the user to grant permission.
  bool? userConfirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(context.localization.permissionRequired),
        content: Text(context
            .localization.doYouWantToGrantStoragePermissionToDownloadTheFile),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.localization.no),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.localization.yes),
          ),
        ],
      );
    },
  );

  if (userConfirmed == true) {
    // Request permission.
    bool permissionGranted = await requestStoragePermission();
    if (!permissionGranted) {
      Fluttertoast.showToast(
        msg: context.localization.storagePermissionIsRequiredToDownloadTheFile,
        backgroundColor: Colors.red,
      );
      return;
    }
    Fluttertoast.showToast(
      msg: context.localization.permissionGrantedDownloadingFile,
      backgroundColor: Colors.green,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CvScreen(),
      ),
    );
  }
}
