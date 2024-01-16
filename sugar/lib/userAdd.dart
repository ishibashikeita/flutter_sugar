import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/services.dart';
import 'package:sugar/firebase/db.dart';
import 'package:sugar/main.dart';
import 'package:sugar/models/user.dart';

class UserAdd extends StatefulWidget {
  UserAdd({super.key});

  @override
  State<UserAdd> createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String name = '';
    final focusNode = FocusNode();
    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          resizeToAvoidBottomInset: false, //キーボードによって画面サイズを変更させないため
          appBar: AppBar(
            title: Text(
              '新規ユーザー登録画面',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.orange.shade400,
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width * 0.9,
                      height: size.height * 0.1,
                      child: Center(
                        child: Text(
                          'WELCOME!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange.shade400,
                              fontSize: 40),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width * 0.6,
                      height: size.height * 0.1,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              color: Colors.orange.shade400, width: 10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'まずは必要な情報を教えてね！',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width * 0.9,
                      height: size.height * 0.2,
                      //color: Colors.red,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('あなたのニックネーム'),
                                  Text(
                                    '*',
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                              Container(
                                width: size.width * 0.8,
                                height: size.height * 0.08,
                                child: Center(
                                  child: TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        name = value;
                                      });
                                    },
                                  ),
                                  // child: TextField(
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       name = value;
                                  //     });
                                  //   },
                                  //   cursorColor: Colors.black,
                                  //   decoration: InputDecoration(
                                  //     border: OutlineInputBorder(),
                                  //     focusedBorder: OutlineInputBorder(
                                  //       borderSide:
                                  //           BorderSide(color: Colors.orange),
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //       width: size.width * 0.9,
                //       height: size.height * 0.35,
                //       color: Colors.red,
                //       child: Center(
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   Text('あなたの性別'),
                //                   Text(
                //                     '*',
                //                     style: TextStyle(color: Colors.red),
                //                   )
                //                 ],
                //               ),
                //               Container(
                //                 width: size.width * 0.9,
                //                 height: size.height * 0.2,
                //                 color: Colors.black,
                //                 child: Center(
                //                   child: Row(
                //                     children: [
                //                       Padding(
                //                         padding: const EdgeInsets.all(8.0),
                //                         child: GestureDetector(
                //                           onTap: () {},
                //                           child: Container(
                //                             width: size.width * 0.25,
                //                             height: size.width * 0.25,
                //                             decoration: BoxDecoration(
                //                               color: (gender == '男性')
                //                                   ? Colors.blue
                //                                   : Colors.red,
                //                               shape: BoxShape.circle,
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                       Padding(
                //                         padding: const EdgeInsets.all(8.0),
                //                         child: GestureDetector(
                //                           onTap: () {
                //                             setwomen;

                //                             print(gender);
                //                           },
                //                           child: Container(
                //                             width: size.width * 0.25,
                //                             height: size.width * 0.25,
                //                             decoration: BoxDecoration(
                //                               color: Colors.red,
                //                               shape: BoxShape.circle,
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                       Padding(
                //                         padding: const EdgeInsets.all(8.0),
                //                         child: GestureDetector(
                //                           onTap: () {},
                //                           child: Container(
                //                             width: size.width * 0.25,
                //                             height: size.width * 0.25,
                //                             decoration: BoxDecoration(
                //                               color: Colors.grey,
                //                               shape: BoxShape.circle,
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               Padding(
                //                 padding: const EdgeInsets.all(8.0),
                //                 child: Container(
                //                   width: size.width * 0.3,
                //                   height: size.height * 0.05,
                //                   child: Center(
                //                     child: Text(
                //                       counter.toString(),
                //                       // (_gender == '男性')
                //                       //     ? '男性'
                //                       //     : (_gender == '女性')
                //                       //         ? '女性'
                //                       //         : 'その他',
                //                       style: TextStyle(fontSize: 20),
                //                     ),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //       width: size.width * 0.9,
                //       height: size.height * 0.2,
                //       //color: Colors.red,
                //       child: Center(
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   Text('平均血糖値'),
                //                   Text(
                //                     '*',
                //                     style: TextStyle(color: Colors.red),
                //                   )
                //                 ],
                //               ),
                //               Container(
                //                 width: size.width * 0.8,
                //                 height: size.height * 0.08,
                //                 child: Center(
                //                   child: TextField(
                //                     cursorColor: Colors.black,
                //                     decoration: InputDecoration(
                //                       border: OutlineInputBorder(),
                //                       focusedBorder: OutlineInputBorder(
                //                         borderSide:
                //                             BorderSide(color: Colors.orange),
                //                       ),
                //                     ),
                //                     onChanged: (value) {
                //                       setState(() {
                //                         _average = int.parse(value);
                //                       });
                //                       print(_average);
                //                     },
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //       width: size.width * 0.9,
                //       height: size.height * 0.2,
                //       //color: Colors.red,
                //       child: Center(
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   Text('目標血糖値'),
                //                   Text(
                //                     '*',
                //                     style: TextStyle(color: Colors.red),
                //                   ),
                //                 ],
                //               ),
                //               Container(
                //                 width: size.width * 0.8,
                //                 height: size.height * 0.08,
                //                 child: Center(
                //                   child: TextField(
                //                     cursorColor: Colors.black,
                //                     decoration: InputDecoration(
                //                       border: OutlineInputBorder(),
                //                       focusedBorder: OutlineInputBorder(
                //                         borderSide:
                //                             BorderSide(color: Colors.orange),
                //                       ),
                //                     ),
                //                     onChanged: (value) {
                //                       setState(() {
                //                         _target = int.parse(value);
                //                       });
                //                       print(_target);
                //                     },
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //       width: size.width * 0.9,
                //       height: size.height * 0.2,
                //       //color: Colors.red,
                //       child: Center(
                //         child: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.start,
                //                 children: [
                //                   Text('血圧'),
                //                 ],
                //               ),
                //               Container(
                //                 width: size.width * 0.8,
                //                 height: size.height * 0.08,
                //                 child: Center(
                //                   child: TextField(
                //                     cursorColor: Colors.black,
                //                     decoration: InputDecoration(
                //                       border: OutlineInputBorder(),
                //                       focusedBorder: OutlineInputBorder(
                //                         borderSide:
                //                             BorderSide(color: Colors.orange),
                //                       ),
                //                     ),
                //                     onChanged: (value) {
                //                       setState(() {
                //                         _blPress = int.parse(value);
                //                       });
                //                       print(_blPress);
                //                     },
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width * 0.9,
                      height: size.height * 0.2,
                      //color: Colors.red,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print(name);
                                },
                                child: Container(
                                  width: size.width * 0.8,
                                  height: size.height * 0.08,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orange.shade400),
                                  child: Center(
                                    child: Text(
                                      '登録を完了してはじめる！',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class confirm extends StatefulWidget {
  confirm({super.key, required this.user});
  User user;

  @override
  State<confirm> createState() => _confirmState();
}

class _confirmState extends State<confirm> {
  @override
  Widget build(BuildContext context) {
    print(widget.user.backName());
    User _user = widget.user;
    return Scaffold(
      body: Center(
        child: Text(_user.name + _user.gender),
      ),
    );
  }
}

class UserAddPage extends StatefulWidget {
  const UserAddPage({super.key});

  @override
  State<UserAddPage> createState() => _UserAddPageState();
}

class _UserAddPageState extends State<UserAddPage> {
  int count = 0;
  List userConf = [];

  String text = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false, //キーボードによって画面サイズを変更させないため
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '新規ユーザー登録画面',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade400,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.1,
                  child: Center(
                    child: Text(
                      'WELCOME!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade400,
                          fontSize: 40),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.6,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(color: Colors.orange.shade400, width: 10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'まずは必要な情報を教えてね！',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.2,
                  //color: Colors.red,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('あなたのニックネーム'),
                              Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          Container(
                            width: size.width * 0.8,
                            height: size.height * 0.08,
                            child: Center(
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    text = value;
                                  });
                                },
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.03,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    '※後から変更できます。',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.2,
                  //color: Colors.red,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (text != '') {
                                userConf.add(text);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserAddPage2(userConf: userConf),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: size.width * 0.8,
                              height: size.height * 0.08,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange.shade400),
                              child: Center(
                                child: Text(
                                  '次に進む！',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAddPage2 extends StatefulWidget {
  UserAddPage2({super.key, required this.userConf});
  List userConf;

  @override
  State<UserAddPage2> createState() => _UserAddPageState2();
}

class _UserAddPageState2 extends State<UserAddPage2> {
  int count = 0;

  String _gender = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false, //キーボードによって画面サイズを変更させないため
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '新規ユーザー登録画面',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade400,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.1,
                  child: Center(
                    child: Text(
                      'WELCOME!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade400,
                          fontSize: 40),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.6,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(color: Colors.orange.shade400, width: 10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'まずは必要な情報を教えてね！',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.35,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('あなたの性別'),
                              Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          Container(
                            width: size.width * 0.9,
                            height: size.height * 0.2,
                            child: Center(
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _gender = '男性';
                                        });
                                      },
                                      child: Container(
                                        width: size.width * 0.25,
                                        height: size.width * 0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.man,
                                            color: Colors.white,
                                            size: size.width * 0.15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _gender = '女性';
                                        });
                                      },
                                      child: Container(
                                        width: size.width * 0.25,
                                        height: size.width * 0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.woman,
                                            color: Colors.white,
                                            size: size.width * 0.15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _gender = 'その他';
                                        });
                                      },
                                      child: Container(
                                        width: size.width * 0.25,
                                        height: size.width * 0.25,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.wc,
                                            color: Colors.white,
                                            size: size.width * 0.15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: size.width * 0.3,
                              height: size.height * 0.05,
                              child: Center(
                                child: Text(
                                  (_gender == '男性')
                                      ? '男性'
                                      : (_gender == '女性')
                                          ? '女性'
                                          : 'その他',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.03,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    '※後から変更できます。',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.2,
                  //color: Colors.red,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_gender != '') {
                                widget.userConf.add(_gender);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        UserAddPage3(userConf: widget.userConf),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: size.width * 0.8,
                              height: size.height * 0.08,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange.shade400),
                              child: Center(
                                child: Text(
                                  '次に進む！',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAddPage3 extends StatefulWidget {
  UserAddPage3({super.key, required this.userConf});
  List userConf;

  @override
  State<UserAddPage3> createState() => _UserAddPageState3();
}

class _UserAddPageState3 extends State<UserAddPage3> {
  int _average = 0;
  int _target = 0;
  int _blPress = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false, //キーボードによって画面サイズを変更させないため
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          '新規ユーザー登録画面',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade400,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.1,
                  child: Center(
                    child: Text(
                      'WELCOME!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade400,
                          fontSize: 40),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.6,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(color: Colors.orange.shade400, width: 10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'まずは必要な情報を教えてね！',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.2,
                  //color: Colors.red,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('平均血糖値'),
                              Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          Container(
                            width: size.width * 0.8,
                            height: size.height * 0.08,
                            child: Center(
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == '') {
                                      _average = 0;
                                    } else {
                                      print(value);
                                      _average = int.parse(value);
                                    }
                                  });
                                  print(_average);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.2,
                  //color: Colors.red,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('目標血糖値'),
                              Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          Container(
                            width: size.width * 0.8,
                            height: size.height * 0.08,
                            child: Center(
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == '') {
                                      _target = 0;
                                    } else {
                                      print(value);
                                      _target = int.parse(value);
                                    }
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.2,
                  //color: Colors.red,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('血圧'),
                              Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          Container(
                            width: size.width * 0.8,
                            height: size.height * 0.08,
                            child: Center(
                              child: TextField(
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(3),
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (value == '') {
                                      _blPress = 0;
                                    } else {
                                      print(value);
                                      _blPress = int.parse(value);
                                    }
                                  });
                                  print(_blPress);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: size.width * 0.8,
                height: size.height * 0.03,
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    '※後から変更できます。',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: size.width * 0.9,
                  height: size.height * 0.2,
                  //color: Colors.red,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_average != 0 ||
                                  _blPress != 0 ||
                                  _target != 0) {
                                widget.userConf
                                    .addAll([_average, _target, _blPress]);
                                print(widget.userConf);
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: const Text('※確認'),
                                      content: const Text('この情報で登録しますか'),
                                      actions: <CupertinoDialogAction>[
                                        CupertinoDialogAction(
                                          isDefaultAction: true,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'キャンセル',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        CupertinoDialogAction(
                                          isDestructiveAction: true,
                                          onPressed: () {
                                            final service = AuthService();
                                            service.AuthAdd(widget.userConf);
                                            // setState(() {
                                            //   Navigator.of(context).popUntil(
                                            //       (route) => route.isFirst);
                                            // });

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyApp()),
                                            );
                                          },
                                          child: Text(
                                            'OK',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        )
                                      ],
                                    );
                                    // return AlertDialog(
                                    //   title: Text("※確認"),
                                    //   content: Text("この情報で登録しますか？"),
                                    //   actions: [
                                    //     TextButton(
                                    //       child: Text("Cancel"),
                                    //       onPressed: () {
                                    //         Navigator.pop(context);
                                    //       },
                                    //     ),
                                    //     TextButton(
                                    //         child: Text("OK"),
                                    //         onPressed: () {
                                    //           final service = AuthService();
                                    //           service.AuthAdd(widget.userConf);
                                    //           // setState(() {
                                    //           //   Navigator.of(context).popUntil(
                                    //           //       (route) => route.isFirst);
                                    //           // });

                                    //           Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     MyApp()),
                                    //           );
                                    //         }),
                                    //   ],
                                    // );
                                  },
                                );
                              }
                            },
                            child: Container(
                              width: size.width * 0.8,
                              height: size.height * 0.08,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange.shade400),
                              child: Center(
                                child: Text(
                                  '登録する！',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
