import 'dart:collection';
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
