import 'package:fluttertoast/fluttertoast.dart';

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
      msg: "Permission already granted! Downloading file...",
      backgroundColor: Colors.green,
    );
    // Navigate to CvScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CvScreen(
          jobDescription: jobDescription,
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
        title: const Text('Permission Required'),
        content: const Text(
            'Do you want to grant storage permission to download the file?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes'),
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
        msg: "Storage permission is required to download the file.",
        backgroundColor: Colors.red,
      );
      return;
    }
    Fluttertoast.showToast(
      msg: "Permission granted! Downloading file...",
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
