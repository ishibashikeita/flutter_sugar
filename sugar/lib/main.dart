import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sugar/firebase/db.dart';
import 'package:sugar/userAdd.dart';
import 'firebase_options.dart';
import 'check.dart';
import 'profile.dart';
import 'push.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting('ja');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // スプラッシュ画面などに書き換えても良い
            return const SizedBox();
          }
          if (snapshot.hasData) {
            // User が null でなない、つまりサインイン済みのホーム画面へ
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => MyHomePage(),
            //     ),
            //   );
            // });

            return MyHomePage();
          }
          // User が null である、つまり未サインインのサインイン画面へ
          return googleLogin();
        },
      ),
    );
  }
}

class googleLogin extends StatefulWidget {
  const googleLogin({super.key});

  @override
  State<googleLogin> createState() => _googleLoginState();
}

class _googleLoginState extends State<googleLogin> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orange.shade400,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: size.width * 0.5,
              height: size.width * 0.5,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/sugar.png'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.2,
          ),
          GestureDetector(
            onTap: () {
              print(00);
              try {
                AuthService().signWithGoogle();
              } catch (e) {
                print(e);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: size.width * 0.9,
                height: size.height * 0.1,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(0.5)),
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.height * 0.1,
                          height: size.height * 0.1,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/Google.png'),
                            ),
                          ),
                        ),
                      ),
                      Text('Googleアカウントでサインイン'),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Check(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void setstatewidget() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService().userCheck(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.orange.shade400,
                ),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          print(snapshot.data);
          if (snapshot.data == true) {
            return Scaffold(
              body: _widgetOptions.elementAt(_selectedIndex),
              floatingActionButton: Container(
                width: 80,
                height: 80,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            Push3(
                          date: DateTime.now(),
                        ),
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
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.draw,
                        size: 40,
                        color: Colors.white,
                      ),
                      Text(
                        '記録',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  shape: CircleBorder(),
                  backgroundColor: Colors.orange.shade400,
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.query_stats),
                    label: 'チャート',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    label: 'プロフィール',
                  ),
                ],
                currentIndex: _selectedIndex,
                backgroundColor: Colors.grey[100],
                selectedItemColor: Colors.orange.shade400,
                onTap: _onItemTapped, //Iconタップ時のイベント
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserAddPage(),
                ),
              );
            });
            return Container();
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
