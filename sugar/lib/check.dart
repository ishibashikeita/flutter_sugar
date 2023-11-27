import 'dart:collection';

import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sugar/firebase/db.dart';
import 'package:sugar/lineChart.dart';
import 'package:sugar/pricePoints.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  String now_time = '';
  late int sugarCount;
  final service = FirebaseService();
  late Future _data;

  @override
  void initState() {
    super.initState();
    now_time = DateFormat('yyyy年M月dd日').format(DateTime.now()).toString();
    _data = service.db.collection('user').doc('profile').get();

    sugarCount = 8;
  }

  @override
  Widget build(BuildContext context) {
    final service = FirebaseService();
    var _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, _screenSize.height * 0.05),
        child: AppBar(
          backgroundColor: Colors.orange.shade400,
          title: Text(
            now_time,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.orange.shade400,
            height: _screenSize.height * 0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder(
                            stream: service.db
                                .collection('user')
                                .doc('profile')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData == true) {
                                Map<String, dynamic> map = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                return Text(
                                  map['ニックネーム'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              } else {
                                return Text(
                                  'ニックネーム',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                            }),
                        FutureBuilder(
                            future: service.db
                                .collection('user')
                                .doc('record')
                                .get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> map = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                final Map<String, dynamic> map2 =
                                    SplayTreeMap.from(
                                        map, (a, b) => b.compareTo(a));
                                final List list = map2.values.toList()
                                  ..length = 7;

                                return Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    list[0].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                  ),
                                  width: 60,
                                  height: 25,
                                );
                              }
                              return Text('...');
                            }),
                      ],
                    ),
                    StreamBuilder(
                        stream: service.db
                            .collection('user')
                            .doc('profile')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Map<String, dynamic> map =
                                snapshot.data!.data() as Map<String, dynamic>;

                            return (map['性別'] == '男性')
                                ? Icon(
                                    Icons.man,
                                    size: 40,
                                    color: Colors.blue.shade400,
                                  )
                                : (map['性別'] == '女性')
                                    ? Icon(
                                        Icons.woman,
                                        size: 40,
                                        color: Colors.red.shade400,
                                      )
                                    : Icon(
                                        Icons.wc,
                                        size: 40,
                                        color: Colors.grey.shade600,
                                      );
                          } else {
                            return Icon(
                              Icons.man,
                              size: 40,
                              color: Colors.blue.shade400,
                            );
                          }
                        }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.white,
                        )),
                    width: _screenSize.width * 0.4,
                    height: _screenSize.height * 0.05,
                    child: Center(
                        child: StreamBuilder(
                            stream: service.db
                                .collection('user')
                                .doc('profile')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData == true) {
                                Map<String, dynamic> map = snapshot.data!.data()
                                    as Map<String, dynamic>;
                                return Text(
                                  '目標血糖値 : ' +
                                      map['目標血糖値'].toString() +
                                      'mg/dl',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              } else {
                                return const Text(
                                  '目標血糖値 : 100' + 'mg/dl',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                            })),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '血糖値チャート',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: _screenSize.height * 0.5,
                    width: _screenSize.width * 0.9,
                    child: LineChartWidget(pricePoints),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '過去の確認',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                      stream: service.db
                          .collection('user')
                          .doc('record')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData == true) {
                          Map<dynamic, dynamic> map =
                              snapshot.data!.data() as Map<String, dynamic>;
                          map =
                              SplayTreeMap.from(map, (a, b) => b.compareTo(a));

                          return ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: _screenSize.height * 0.6,
                                maxHeight: _screenSize.height * 12),
                            child: Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: sugarCount,
                                itemBuilder: (context, index) {
                                  if (index < (sugarCount - 1)) {
                                    int face = 0;
                                    return Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                        top: BorderSide(
                                            color:
                                                Colors.black.withOpacity(0.2)),
                                      )),
                                      child: ListTile(
                                        tileColor: Colors.grey.shade200,
                                        leading: Text(
                                          DateFormat('M月dd日(')
                                                  .format(DateTime.parse(map
                                                      .keys
                                                      .elementAt(index)))
                                                  .toString() +
                                              DateFormat.E('ja')
                                                  .format(DateTime.parse(map
                                                      .keys
                                                      .elementAt(index)))
                                                  .toString() +
                                              ')',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        title: Row(
                                          children: [
                                            SizedBox(
                                              width: _screenSize.width * 0.1,
                                            ),
                                            Text(
                                              map.values
                                                  .elementAt(index)
                                                  .toString(),
                                              style: TextStyle(fontSize: 25),
                                            ),
                                            Text(
                                              'mg/dl',
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            SizedBox(
                                              width: _screenSize.width * 0.02,
                                            ),
                                            StreamBuilder(
                                                stream: service.db
                                                    .collection('user')
                                                    .doc('profile')
                                                    .snapshots(),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    Map<String, dynamic> map2 =
                                                        snapshot.data!.data()
                                                            as Map<String,
                                                                dynamic>;

                                                    int k = map.values
                                                        .elementAt(index);

                                                    int i = (k -
                                                        int.parse(
                                                            map2['目標血糖値']));

                                                    return (i.isNegative)
                                                        ? (i.abs() < 20)
                                                            ? Text(
                                                                '(' +
                                                                    i.toString() +
                                                                    ')',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .green),
                                                              )
                                                            : (i.abs() < 40)
                                                                ? Text(
                                                                    '(' +
                                                                        i.toString() +
                                                                        ')',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .orange
                                                                          .shade400,
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    '(' +
                                                                        i.toString() +
                                                                        ')',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  )
                                                        : (i.abs() < 20)
                                                            ? Text(
                                                                '(+' +
                                                                    i.toString() +
                                                                    ')',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                        .green),
                                                              )
                                                            : (i.abs() < 40)
                                                                ? Text(
                                                                    '(+' +
                                                                        i.toString() +
                                                                        ')',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .orange
                                                                          .shade400,
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    '(+' +
                                                                        i.toString() +
                                                                        ')',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  );
                                                  } else {
                                                    return Text(
                                                      '(+0.1)',
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    );
                                                  }
                                                }),
                                          ],
                                        ),
                                        trailing: FutureBuilder(
                                            future: _data,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasError) {
                                                return const SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child:
                                                        CircularProgressIndicator(
                                                      valueColor:
                                                          AlwaysStoppedAnimation(
                                                              Colors.blue),
                                                      strokeWidth: 8.0,
                                                    ));
                                              }
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                int k =
                                                    map.values.elementAt(index);
                                                Map<String, dynamic> map2 =
                                                    snapshot.data!.data()
                                                        as Map<String, dynamic>;
                                                int i = (k -
                                                    int.parse(map2['目標血糖値']));
                                                return (i.abs() < 20)
                                                    ? Icon(
                                                        Icons.mood,
                                                        color: Colors.green,
                                                        size: 35,
                                                      )
                                                    : (i.abs() < 40)
                                                        ? Icon(
                                                            Icons
                                                                .sentiment_satisfied,
                                                            color: Colors.orange
                                                                .shade400,
                                                            size: 35,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .sentiment_very_dissatisfied,
                                                            color: Colors.red,
                                                            size: 35,
                                                          );
                                              }
                                              return Text('loading');
                                            }),
                                        // trailing: Icon(
                                        //   Icons.mood,
                                        //   color: Colors.green,
                                        //   size: 35,
                                        // ),
                                      ),
                                    );
                                  } else {
                                    return ListTile(
                                      onTap: () {
                                        if (sugarCount < 32) {
                                          setState(() {
                                            sugarCount += 8;
                                          });
                                        } else {}
                                      },
                                      title: Icon(Icons.expand_more),
                                      tileColor: Colors.grey.shade200,
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        }
                        return Container(
                          height: _screenSize.height * 0.5,
                          width: _screenSize.width * 0.9,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 7 + 1,
                            itemBuilder: (context, index) {
                              return (index != 7)
                                  ? ListTile(
                                      tileColor: Colors.grey.shade200,
                                      leading: const Text(
                                        '10月10日',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      title: Row(
                                        children: [
                                          SizedBox(
                                            width: _screenSize.width * 0.05,
                                          ),
                                          Text(
                                            (index * 10).toString(),
                                            style: TextStyle(fontSize: 25),
                                          ),
                                          Text(
                                            'mg/dl',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          SizedBox(
                                            width: _screenSize.width * 0.01,
                                          ),
                                          Text(
                                            '(+0.1)',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ListTile(
                                      tileColor: Colors.grey.shade200,
                                      title: Center(
                                        child: IconButton(
                                          icon: Icon(Icons.expand_more),
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                            },
                          ),
                        );
                      }),
                  SizedBox(
                    height: _screenSize.height * 0.1,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
