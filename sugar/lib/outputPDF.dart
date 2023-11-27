import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'pdfcreator.dart';
import 'pdfPreview.dart';
import 'package:fluttertoast/fluttertoast.dart';

class outPDF extends StatefulWidget {
  const outPDF({super.key});

  @override
  State<outPDF> createState() => _outPDFState();
}

class _outPDFState extends State<outPDF> {
  String _name = '';
  int outWeek = 7;

  selected(int? s) {
    setState(() {
      outWeek = s!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PDF出力ページ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange.shade400,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: size.width * 0.9,
                height: size.height * 0.2,
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'PDFタイトル',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontFamily: 'Hiragino Kaku Gothic ProN',
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.orange.shade400,
                            ),
                          ),
                        ),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red, fontSize: 25),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * 0.7,
                          height: size.height * 0.07,
                          //color: Colors.black,
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(12)
                            ],
                            decoration: InputDecoration(
                              hintText: 'ファイルのタイトルを記述',
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              _name = value;
                              print(_name);
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Container(
              width: size.width * 0.9,
              height: size.height * 0.2,
              //color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '抽出期間(Week)',
                          style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontFamily: 'Hiragino Kaku Gothic ProN',
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange.shade400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.7,
                        height: size.height * 0.07,
                        //color: Colors.black,
                        child: DropdownButton(
                          items: [
                            DropdownMenuItem(
                              value: 7,
                              child: Text('1週間分の記録を抽出'),
                            ),
                            DropdownMenuItem(
                              value: 14,
                              child: Text('2週間分の記録を抽出'),
                            ),
                            DropdownMenuItem(
                              value: 21,
                              child: Text('3週間分の記録を抽出'),
                            ),
                            DropdownMenuItem(
                              value: 31,
                              child: Text('4週間分の記録を抽出'),
                            )
                          ],
                          value: outWeek,
                          onChanged: (value) {
                            selected(value);
                            print(outWeek);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Container(
              width: size.width * 0.9,
              height: size.height * 0.2,
              //color: Colors.red,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return PreviewPage(
                                  week: outWeek,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          'PDFプレビュー',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          if (_name != '') {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return PreviewPage2(
                                    week: outWeek,
                                    name: _name,
                                  );
                                },
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "PDFタイトルが空です。",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black.withOpacity(0.5),
                                textColor: Colors.white,
                                fontSize: 25.0);
                          }
                        },
                        child: Text(
                          '出力',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
