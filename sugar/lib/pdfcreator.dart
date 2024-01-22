import 'dart:collection';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'Tabledata.dart';
import 'package:sugar/firebase/db.dart';
import 'package:intl/intl.dart';

class Pdfcreator {
  Future<Uint8List> create(int w, String s) async {
    final pdf = Document(
      title: 'f',
    );
    // assetsから読み込む場合はこの形。
    // final fontData = await rootBundle.load('assets/ShipporiMincho-Regular.ttf');
    // final font = Font.ttf(fontData);
    final Font font = await PdfGoogleFonts.shipporiMinchoRegular();

    List _sugar = [];
    final service = FirebaseService();
    final _data = await service.db
        .collection(service.auth.currentUser!.uid)
        .doc('record')
        .get();
    final pdfName = await service.db
        .collection(service.auth.currentUser!.uid)
        .doc('profile')
        .get();
    Map<dynamic, dynamic> sn = _data.data() as Map<String, dynamic>;

    sn = SplayTreeMap.from(sn, (a, b) => b.compareTo(a));
    DateTime date = DateTime.now();
    String datepdf = DateFormat('yyyy年MM月d日').format(date).toString();

    final list = sn.entries
        .map(
          (e) => {e.key, e.value},
        )
        .toList();
    final list2 = list..length = w;
    print(list2);

    final firstPage = Page(
      pageTheme: PageTheme(
        theme: ThemeData.withFont(base: font),
        pageFormat: PdfPageFormat.a4,
        orientation: PageOrientation.portrait,
      ),
      build: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                s,
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(datepdf),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(pdfName['ニックネーム'].toString()),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return Container(
                    width: 125,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: PdfColors.black),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (index < list2.length)
                              ? DateFormat('yyyy年MM月d日').format(
                                  DateTime.parse(list2[index].first),
                                )
                              : '',
                        ),
                      ],
                    ),
                  );
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 125,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: PdfColors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (index < list2.length)
                                ? list2[index].last.toString() + 'mh/dl'
                                : '',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 125,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: PdfColors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (index + 15 < list2.length)
                                ? DateFormat('yyyy年MM月d日').format(
                                    DateTime.parse(list2[index + 15].first),
                                  )
                                : '',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 125,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: PdfColors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            (index + 15 < list2.length)
                                ? list2[index + 15].last.toString() + 'mh/dl'
                                : '',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('担当医:'),
              Container(
                height: 30,
                width: 150,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: PdfColors.black),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
    pdf.addPage(firstPage);

    return pdf.save();
    // return pdf.save();
  }
}
