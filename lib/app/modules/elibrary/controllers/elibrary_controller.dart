import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/ApiURL.dart';
import '../../pdfview/bindings/pdfview_binding.dart';
import '../../pdfview/views/pdfview_view.dart';

class ElibraryController extends GetxController {
  var tags = [].obs;
  var books = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getBooks();
  }

  Future getBooks() async {
    // var response = await http
    //     .get(Uri.parse("https://potterapi-fedeperin.vercel.app/en/books"));
    // dynamic decode = jsonDecode(response.body);
    // books.value = decode;

    var responsetag = await http.get(ApiURL.elibrary_tags);
    dynamic decodeTag = jsonDecode(responsetag.body);
    tags.value = decodeTag['result'];

    var response = await http.get(ApiURL.elibrary_books);
    dynamic decode = jsonDecode(response.body);
    books.value = decode['result'];
  }
  
  loadPDF(item) {
    Get.to(PdfviewView(), binding: PdfviewBinding(), arguments: {"name": item['name'], "url": item['url']}, transition: Transition.rightToLeft);

    //Get.toNamed('pdfview', arguments: {"title": "PDF VIEW", "url": "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"});
    //Get.to(PdfviewView(), binding: PdfviewBinding(), arguments: {"title": "PDF VIEW", "url": "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"}, transition: Transition.leftToRight);
    //Get.toNamed('/pdfview', arguments: {"title": "PDF VIEW", "url": "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf"}, transition: Transition.leftToRight);
  }
  
}
