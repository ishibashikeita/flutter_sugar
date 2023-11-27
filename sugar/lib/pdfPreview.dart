import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'pdfcreator.dart';

class PreviewPage extends StatelessWidget {
  PreviewPage({super.key, required this.week});
  int week;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String name = 'preview';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade400,
        title: Text(
          'PDFプレビュー',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: PdfPreview(
        maxPageWidth: size.width * 0.99,
        allowPrinting: false,
        allowSharing: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        loadingWidget: CircularProgressIndicator(
          color: Colors.orange.shade400,
        ),
        build: (format) async {
          final previewPdf = Pdfcreator().create(week, name);
          return await previewPdf;
        },
      ),
    );
  }
}

class PreviewPage2 extends StatelessWidget {
  PreviewPage2({super.key, required this.week, required this.name});
  int week;
  String name;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade400,
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: PdfPreview(
        maxPageWidth: size.width * 0.99,
        allowPrinting: true,
        allowSharing: true,
        canChangeOrientation: false,
        canChangePageFormat: false,
        canDebug: false,
        loadingWidget: CircularProgressIndicator(
          color: Colors.orange.shade400,
        ),
        build: (format) async {
          final previewPdf = Pdfcreator().create(week, name);
          return await previewPdf;
        },
      ),
    );
  }
}
