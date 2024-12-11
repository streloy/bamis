import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../controllers/pdfview_controller.dart';

class PdfviewView extends GetView<PdfviewController> {
  const PdfviewView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(()=> Text(controller.name.value)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.cloud_download,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              print("Saim");
            },
          ),
        ],
      ),
      body: Center(
        child: Obx(()=> SfPdfViewer.network(
          controller.url.value,
          pageLayoutMode: PdfPageLayoutMode.single,
        ),),
      ),
    );
  }
}
