import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sugar/check.dart';
import 'package:sugar/firebase/db.dart';
import 'package:sugar/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Push extends StatefulWidget {
  Push({super.key, required this.param});
  Map<String, dynamic> param;

  @override
  State<Push> createState() => _PushState();
}

class _PushState extends State<Push> {
  @override
  Widget build(BuildContext context) {
    final service = FirebaseService();
    var _screenSize = MediaQuery.of(context).size;
    var data = widget.param.values.elementAt(0);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              widget.param.keys.elementAt(0) + ' !',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade400,
                  fontSize: 40),
            ),
            Text(
              'あなたの' + widget.param.keys.elementAt(0) + 'を設定しよう。',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: _screenSize.height * 0.1,
            ),
            Text(
              widget.param.keys.elementAt(0),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Container(
              width: _screenSize.width * 0.9,
              height: _screenSize.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Container(
                            child: (widget.param.keys.elementAt(0) == 'ニックネーム')
                                ? TextField(
                                    onChanged: (value) {
                                      data = value;
                                    },
                                    controller: TextEditingController(
                                        text: widget.param.values.elementAt(0)),
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(8)
                                    ],
                                  )
                                : TextField(
                                    onChanged: (value) {
                                      data = value;
                                    },
                                    controller: TextEditingController(
                                        text: widget.param.values
                                            .elementAt(0)
                                            .toString()),
                                    //keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(3)
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      (widget.param.keys.elementAt(0) == 'ニックネーム')
                          ? Text('')
                          : (widget.param.keys.elementAt(0) == '血圧')
                              ? Text('mmHg',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey))
                              : Text(
                                  'mg/dl',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  if (data != '') {
                    service.db
                        .collection(service.auth.currentUser!.uid)
                        .doc('profile')
                        .update({widget.param.keys.elementAt(0): data});
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(
                        msg: "ニックネームを入力してください。",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        fontSize: 20.0);
                  }
                },
                child: Text(
                  '決定',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Push2 extends StatefulWidget {
  Push2({super.key, required this.param});
  Map<String, dynamic> param;

  @override
  State<Push2> createState() => _PushState2();
}

class _PushState2 extends State<Push2> {
  @override
  Widget build(BuildContext context) {
    final service = FirebaseService();
    var _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              widget.param.keys.elementAt(0) + ' !',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade400,
                  fontSize: 40),
            ),
            Text(
              'あなたの' + widget.param.keys.elementAt(0) + 'を設定しよう。',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: _screenSize.height * 0.1,
            ),
            Text(
              '性別 : ' + widget.param.values.elementAt(0),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Container(
              width: _screenSize.width * 0.9,
              height: _screenSize.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.param[
                                        widget.param.keys.elementAt(0)] = '男性';
                                  });
                                },
                                child: Icon(
                                  Icons.man,
                                  size: 55,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor: Colors.blue)),
                          ),
                          Text(
                            '男性',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.param[
                                        widget.param.keys.elementAt(0)] = '女性';
                                  });
                                },
                                child: Icon(
                                  Icons.woman,
                                  size: 55,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor: Colors.red)),
                          ),
                          Text(
                            '女性',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    widget.param[
                                        widget.param.keys.elementAt(0)] = 'その他';
                                  });
                                },
                                child: Icon(
                                  Icons.wc,
                                  size: 55,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    backgroundColor: Colors.grey)),
                          ),
                          Text(
                            'その他',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  service.db
                      .collection(service.auth.currentUser!.uid)
                      .doc('profile')
                      .update({
                    widget.param.keys.elementAt(0):
                        widget.param.values.elementAt(0)
                  });

                  Navigator.pop(context);
                },
                child: Text(
                  '決定',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Push3 extends StatefulWidget {
  Push3({super.key, required this.date});
  DateTime date;

  @override
  State<Push3> createState() => _PushState3();
}

class _PushState3 extends State<Push3> {
  @override
  Widget build(BuildContext context) {
    final service = FirebaseService();
    var _screenSize = MediaQuery.of(context).size;
    var dat = DateFormat('yyyy年M月dd日').format(widget.date);

    var input;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'RECORD !',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade400,
                  fontSize: 40),
            ),
            Text(
              '今日の血糖値を設定しよう。',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: _screenSize.height * 0.1,
            ),
            Text(
              dat.toString() + 'の記録',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Container(
              width: _screenSize.width * 0.9,
              height: _screenSize.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Container(
                              child: TextFormField(
                                  onChanged: (value) {
                                    print(value);
                                    input = value;
                                    print(input.runtimeType);
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                LengthLimitingTextInputFormatter(3),
                                FilteringTextInputFormatter.digitsOnly
                              ])),
                        ),
                      ),
                      const Text(
                        'mg/dl',
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  if (input == null || input.toString() == '') {
                    Fluttertoast.showToast(
                        msg: "数値を入力してください。",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        fontSize: 25.0);
                  } else if (int.parse(input) <= 200) {
                    // final sn = service.db
                    //     .collection('user')
                    //     .doc('record')
                    //     .collection(DateTime.now().toString())
                    //     .get();
                    // print(sn);
                    print(DateTime.now());
                    service.updateUser(
                        DateTime.now().toString(), int.parse(input));

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return MyApp();
                        },
                      ),
                    );
                  } else {
                    Fluttertoast.showToast(
                        msg: "正しい値を入力してください。",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        fontSize: 25.0);
                  }
                },
                child: Text(
                  '決定',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Push4 extends StatefulWidget {
  Push4({super.key, required this.param});
  Map<String, dynamic> param;

  @override
  State<Push4> createState() => _PushState4();
}

class _PushState4 extends State<Push4> {
  @override
  Widget build(BuildContext context) {
    final service = FirebaseService();
    var _screenSize = MediaQuery.of(context).size;
    var data = widget.param.values.elementAt(0);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              widget.param.keys.elementAt(0) + ' !',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade400,
                  fontSize: 40),
            ),
            Text(
              'あなたの' + widget.param.keys.elementAt(0) + 'を設定しよう。',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: _screenSize.height * 0.1,
            ),
            Text(
              widget.param.keys.elementAt(0),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Container(
              width: _screenSize.width * 0.9,
              height: _screenSize.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Container(
                            child: (widget.param.keys.elementAt(0) == 'ニックネーム')
                                ? TextField(
                                    onChanged: (value) {
                                      data = value;
                                      print(data);
                                    },
                                    controller: TextEditingController(
                                        text: widget.param.values.elementAt(0)),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(3),
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                  )
                                : TextField(
                                    onChanged: (value) {
                                      data = value;
                                      print(data.runtimeType);
                                    },
                                    controller: TextEditingController(
                                        text: widget.param.values
                                            .elementAt(0)
                                            .toString()),
                                    //keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(3)
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      (widget.param.keys.elementAt(0) == 'ニックネーム')
                          ? Text('')
                          : (widget.param.keys.elementAt(0) == '血圧')
                              ? Text('mmHg',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey))
                              : Text(
                                  'mg/dl',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  if (data != '') {
                    if (int.parse(data) <= 200) {
                      service.db
                          .collection(service.auth.currentUser!.uid)
                          .doc('profile')
                          .update({widget.param.keys.elementAt(0): data});
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(
                          msg: "正しい値を入力してください。",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          textColor: Colors.white,
                          fontSize: 25.0);
                    }
                  } else {
                    Fluttertoast.showToast(
                        msg: "数値を入力してください。",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        fontSize: 25.0);
                  }
                },
                child: Text(
                  '決定',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Push5 extends StatefulWidget {
  Push5({super.key, required this.param});
  Map<String, dynamic> param;

  @override
  State<Push5> createState() => _PushState5();
}

class _PushState5 extends State<Push5> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future upload(File image) async {
    final imageFile = File(image.path);
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      await storage.ref('images').child('sample.png').putFile(imageFile);
    } catch (e) {
      print(e);
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    final service = FirebaseService();
    var _screenSize = MediaQuery.of(context).size;
    var data = widget.param.values.elementAt(0);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(''),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              widget.param.keys.elementAt(0) + ' !',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade400,
                  fontSize: 40),
            ),
            Text(
              'あなたの' + widget.param.keys.elementAt(0) + 'を設定しよう。',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: _screenSize.height * 0.1,
            ),
            Text(
              widget.param.keys.elementAt(0),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Container(
              width: _screenSize.width * 0.9,
              height: _screenSize.height * 0.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  image != null
                      ? Container(
                          width: _screenSize.width * 0.5,
                          height: _screenSize.width * 0.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(image!), fit: BoxFit.cover),
                            shape: BoxShape.circle,
                          ),
                        )
                      : Container(
                          width: _screenSize.width * 0.5,
                          height: _screenSize.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.orange.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        pickImage();
                      },
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: _screenSize.height * 0.1,
            ),
            SizedBox(
              height: 70,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  if (image != null) {
                    upload(image!);
                    Navigator.pop(context);
                  } else {
                    Fluttertoast.showToast(
                        msg: "画像を選択してください。",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        fontSize: 25.0);
                  }
                },
                child: Text(
                  '決定',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade400,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
