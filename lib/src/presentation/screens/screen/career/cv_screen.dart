import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/common/common_imports.dart';

class CvScreen extends StatefulWidget {
  final String filePath;
  const CvScreen({super.key, required this.filePath});

  @override
  State<CvScreen> createState() => _CvScreenState();
}

class _CvScreenState extends State<CvScreen> {
  PDFDocument? document;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      PDFDocument pdf = await PDFDocument.fromFile(File(widget.filePath));
      setState(() {
        document = pdf;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
      Fluttertoast.showToast(
        msg: "Error loading CV: $e",
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your CV')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : (document == null
              ? const Center(child: Text('Failed to load CV.'))
              : PDFViewer(document: document!)),
    );
  }
}
