import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CoverSheetScreen extends StatelessWidget {
  final String? response;

  const CoverSheetScreen({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cover Sheet')),
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
    );
  }
}
