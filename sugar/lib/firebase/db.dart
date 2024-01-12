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

  signOutGoogle() async {
    FirebaseAuth.instance.signOut();
  }

  Future userCheck() async {
    try {
      final _user = FirebaseAuth.instance;
      final collectionRef =
          FirebaseFirestore.instance.collection(_user.currentUser!.uid);
      final querySnapshot = await collectionRef.get();
      final queryDocSnapshot = querySnapshot.docs;
      var data;
      for (final snapshot in queryDocSnapshot) {
        data = snapshot.data();
      }
      return await data;
    } catch (e) {
      print(e);
    }
  }
}
