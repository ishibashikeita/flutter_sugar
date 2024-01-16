import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sugar/firebase/db.dart';
import 'package:sugar/outputPDF.dart';
import 'package:sugar/push.dart';
import 'const/const.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final service = FirebaseService();
    var _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'プロフィール',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade400,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'プロフィール',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            StreamBuilder(
                stream:
                    service.db.collection('user').doc('profile').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> map =
                        snapshot.data!.data() as Map<String, dynamic>;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profile.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map2 = {};
                        map2[map.keys.elementAt(index)] =
                            map[map.keys.elementAt(index)];
                        return Container(
                          height: 70,
                          child: ListTile(
                            onTap: () {
                              if (map.keys.elementAt(index) != '性別') {
                                if (map.keys.elementAt(index) == 'ニックネーム') {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            Push(param: map2),
                                        //この下アニメーション
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          final Offset begin = Offset(0.0, 1.0);
                                          final Offset end = Offset.zero;
                                          final Animatable<Offset> tween =
                                              Tween(begin: begin, end: end)
                                                  .chain(CurveTween(
                                                      curve: Curves.easeInOut));
                                          final Animation<Offset>
                                              offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                      ));
                                } else if (map.keys.elementAt(index) ==
                                    'プロフィール画像') {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            Push5(param: map2),
                                        //この下アニメーション
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          final Offset begin = Offset(0.0, 1.0);
                                          final Offset end = Offset.zero;
                                          final Animatable<Offset> tween =
                                              Tween(begin: begin, end: end)
                                                  .chain(CurveTween(
                                                      curve: Curves.easeInOut));
                                          final Animation<Offset>
                                              offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                      ));
                                } else {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            Push4(param: map2),
                                        //この下アニメーション
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          final Offset begin = Offset(0.0, 1.0);
                                          final Offset end = Offset.zero;
                                          final Animatable<Offset> tween =
                                              Tween(begin: begin, end: end)
                                                  .chain(CurveTween(
                                                      curve: Curves.easeInOut));
                                          final Animation<Offset>
                                              offsetAnimation =
                                              animation.drive(tween);
                                          return SlideTransition(
                                            position: offsetAnimation,
                                            child: child,
                                          );
                                        },
                                      ));
                                }
                              } else {
                                Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          Push2(param: map2),
                                      //この下アニメーション
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        final Offset begin = Offset(0.0, 1.0);
                                        final Offset end = Offset.zero;
                                        final Animatable<Offset> tween =
                                            Tween(begin: begin, end: end).chain(
                                                CurveTween(
                                                    curve: Curves.easeInOut));
                                        final Animation<Offset>
                                            offsetAnimation =
                                            animation.drive(tween);
                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                    ));
                              }
                            },
                            title: Text(map.keys.elementAt(index)),
                            trailing: Wrap(
                              spacing: 8,
                              children: [
                                (map.keys.elementAt(index) == '平均血糖値' ||
                                        map.keys.elementAt(index) == '目標血糖値')
                                    ? Text(
                                        map.values.elementAt(index).toString() +
                                            'mg/dl',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade500))
                                    : (map.keys.elementAt(index) == '血圧')
                                        ? Text(
                                            map.values
                                                    .elementAt(index)
                                                    .toString() +
                                                'mmHg',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey.shade500))
                                        : Text(
                                            map.values
                                                .elementAt(index)
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey.shade500)),
                                Icon(
                                  Icons.arrow_circle_right,
                                  color: Colors.grey.shade500,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: profile.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 70,
                          child: ListTile(
                            onTap: () {},
                            title: Text('zzz'),
                            trailing: Wrap(
                              spacing: 8,
                              children: [
                                profile.values.elementAt(index),
                                Icon(Icons.arrow_circle_right),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '出力',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  outPDF(),
                          //この下アニメーション
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            final Offset begin = Offset(0.0, 1.0);
                            final Offset end = Offset.zero;
                            final Animatable<Offset> tween =
                                Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: Curves.easeInOut));
                            final Animation<Offset> offsetAnimation =
                                animation.drive(tween);
                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        ));
                  },
                  title: Text('PDFで出力'),
                  trailing: Icon(
                    Icons.arrow_circle_right,
                    color: Colors.grey.shade500,
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'ログアウト',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    try {
                      final service = AuthService();
                      final email = await service.backEmail();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text('※ログアウト'),
                            content: Text(email.toString() + 'からログアウトしますか？'),
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
                                  Navigator.pop(context);
                                  AuthService().signOutGoogle();
                                },
                                child: Text(
                                  'OK',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  title: Text('ログアウト'),
                  trailing: Icon(
                    Icons.arrow_circle_right,
                    color: Colors.grey.shade500,
                  ),
                );
              },
            ),
            SizedBox(
              height: _screenSize.height * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
