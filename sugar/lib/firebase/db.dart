import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_ios/google_sign_in_ios.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final db = FirebaseFirestore.instance;
  final db2 = FirebaseFirestore.instance.collection('user');

  Stream readProfile() async* {
    final data = db.collection('user').doc('profile').snapshots();
    yield data;
  }

  Future updateUser(String s, int i) async {
    final _data = await db2.doc('record').get();
    final li = _data.data();
    final Map<String, dynamic> map =
        SplayTreeMap.from(li!, (a, b) => b.compareTo(a));
    final list = map.keys.toList();
    List newList = list
        .map((e) =>
            DateFormat('yyyy年M月dd日').format(DateTime.parse(e)).toString())
        .toList();
    //print(newList);
    //print(DateFormat('yyyy年M月dd日').format(DateTime.parse(s)).toString());
    if (newList.contains(
        DateFormat('yyyy年M月dd日').format(DateTime.parse(s)).toString())) {
      await db2.doc('record').set({list[0]: i}, SetOptions(merge: true));
    } else {
      await db2.doc('record').set({s: i}, SetOptions(merge: true));
    }
  }

  Future weekSugar() async {
    final sn = await db2.doc('record').get();

    final li = sn.data();
    final Map<String, dynamic> map =
        SplayTreeMap.from(li!, (a, b) => b.compareTo(a));
    return map;
  }

  // Stream<Map<String, dynamic>> weekSugar() async* {
  //   final sData = db.collection('user').doc('record').snapshots();

  //   final ssd = sData.map(
  //     (snapshot) => snapshot.data()!,
  //   );

  //   print(ssd);

  //   yield* ssd;
  // }
}

class AuthService {
  signWithGoogle() async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
  }

  Future backEmail() async {
    final email = await FirebaseAuth.instance.currentUser!.email;
    return await email;
  }

  signOutGoogle() async {
    FirebaseAuth.instance.signOut();
  }

  Future userCheck() async {
    try {
      final _user = FirebaseAuth.instance;
      DocumentSnapshot<Map<String, dynamic>> _collectionRef =
          await FirebaseFirestore.instance
              // .collection('user')
              .collection(_user.currentUser!.uid)
              .doc('profile')
              .get();
      //ここをuserに変えれば一旦動く。
      final _check = _collectionRef.exists;
      return _check;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future AuthAdd(List li) async {
    final db = FirebaseFirestore.instance;
    final _user = FirebaseAuth.instance;
    await db.collection(_user.currentUser!.uid).doc('profile').set(
      {
        'ニックネーム': li[0],
        'プロフィール画像': "",
        '性別': li[1].toString(),
        '平均血糖値': li[2].toString(),
        '目標血糖値': li[3].toString(),
        '血圧': li[4].toString(),
      },
      SetOptions(merge: true),
    );
  }
}
