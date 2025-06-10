import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:short_path/core/extensions/extensions.dart';
import 'package:short_path/core/styles/colors/app_colore.dart';

class CoverSheetScreen extends StatelessWidget {
  final String? response;
  final VoidCallback sendEmail;

  CoverSheetScreen(
      {super.key, required this.response, required this.sendEmail});

  final isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.localization.coverSheetB)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Markdown(
            data: response ?? "",
            styleSheet: MarkdownStyleSheet(
              p: const TextStyle(fontSize: 16),
              strong: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          spacing: 8,
          spaceBetweenChildren: 8,
          openCloseDial: isDialOpen,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.email),
              onTap: sendEmail,
            ),
            SpeedDialChild(
              child: const Icon(Icons.copy),
              onTap: () {
                // Implement copy to clipboard functionality
                final data = response ?? "";
                Clipboard.setData(ClipboardData(text: data));
                Fluttertoast.showToast(
                    msg: context.localization.copiedToClipboard);
              },
            ),
          ],
        ),
      ),
    );
  }
}
