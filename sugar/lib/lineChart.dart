import 'dart:collection';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sugar/pricePoints.dart';
import 'package:sugar/firebase/db.dart';
import 'package:collection/collection.dart';

class LineChartWidget extends StatefulWidget {
  final List<PricePoint> points;
  const LineChartWidget(
    this.points, {
    super.key,
  });

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
  final service = FirebaseService();
  late Future _data;

  @override
  void initState() {
    _data = service.db
        .collection(service.auth.currentUser!.uid)
        .doc('record')
        .get();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final service = FirebaseService();
    return FutureBuilder(
        // future: service.db.collection('user').doc('record').get(),
        future: _data,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                  strokeWidth: 8.0,
                ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            try {
              Map<String, dynamic> map =
                  snapshot.data!.data() as Map<String, dynamic>;
              final Map<String, dynamic> map2 =
                  SplayTreeMap.from(map, (a, b) => b.compareTo(a));
              final Map<String, dynamic> map3 =
                  SplayTreeMap.from(map, (b, a) => b.compareTo(a));
              // final List list = map2.values.toList()..length = 7;
              final List list = map2.values.toList();

              if (list.length > 7) {
                list..length = 7;
              }
              final List<int> list2 = list.cast<int>();
              final List<int> list3 = list2.reversed.toList();
              flget() {
                List<FlSpot> fl = [];

                list3.asMap().forEach((index, value) {
                  fl.add(FlSpot(index.toDouble(), value.toDouble()));
                });
                return fl;
              }

              return AspectRatio(
                aspectRatio: 2,
                child: LineChart(
                  LineChartData(
                    maxX: 6,
                    minX: 0,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: 25.0,
                      verticalInterval: 1.0,
                    ),
                    lineTouchData: LineTouchData(
                        handleBuiltInTouches: true,
                        getTouchedSpotIndicator: defaultTouchedIndicators,
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: defaultLineTooltipItem,
                          tooltipBgColor: Colors.white,
                          tooltipBorder:
                              BorderSide(color: Colors.grey.shade400),
                        )),
                    lineBarsData: [
                      LineChartBarData(
                        spots: flget(),
                        // spots: widget.points
                        //     .map((point) => FlSpot(point.x, point.y))
                        //     .toList(),
                        isCurved: false,
                        color: Colors.orange.shade400,
                        //ここがドットの設定
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (p0, p1, p2, p3) => FlDotCirclePainter(
                            color: Colors.orange.shade400,
                            strokeColor: Colors.orange.shade400,
                          ),
                        ),
                      )
                    ],
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        axisNameWidget: Text(
                          "【計測日付】",
                          style: TextStyle(
                            color: Color(0xff68737d),
                          ),
                        ),
                        axisNameSize: 22.0,
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1.0,
                          reservedSize: 40.0,
                          getTitlesWidget: (value, meta) {
                            String text = '';
                            List bottomList = map3.keys.toList();
                            if (bottomList.length > 7) {
                              bottomList = bottomList.reversed.toList();
                              bottomList..length = 7;
                              bottomList = bottomList.reversed.toList();
                            }

                            // final List bottomContents =
                            //     bottomList.reversed.toList();

                            // print(bottomList);
                            // print(bottomContents);

                            switch (value.toInt()) {
                              case 0:
                                if (bottomList.length >= 1) {
                                  text = DateFormat('M/dd')
                                      .format(DateTime.parse(bottomList[0]))
                                      .toString();
                                } else {
                                  text = '';
                                }
                                break;
                              case 1:
                                if (bottomList.length >= 2) {
                                  text = DateFormat('M/dd')
                                      .format(DateTime.parse(bottomList[1]))
                                      .toString();
                                } else {
                                  text = '';
                                }
                                break;
                              case 2:
                                if (bottomList.length >= 3) {
                                  text = DateFormat('M/dd')
                                      .format(DateTime.parse(bottomList[2]))
                                      .toString();
                                } else {
                                  text = '';
                                }
                                break;
                              case 3:
                                if (bottomList.length >= 4) {
                                  text = DateFormat('M/dd')
                                      .format(DateTime.parse(bottomList[3]))
                                      .toString();
                                } else {
                                  text = '';
                                }
                                break;
                              case 4:
                                if (bottomList.length >= 5) {
                                  text = DateFormat('M/dd')
                                      .format(DateTime.parse(bottomList[4]))
                                      .toString();
                                } else {
                                  text = '';
                                }
                                break;
                              case 5:
                                if (bottomList.length >= 6) {
                                  text = DateFormat('M/dd')
                                      .format(DateTime.parse(bottomList[5]))
                                      .toString();
                                } else {
                                  text = '';
                                }
                                break;
                              case 6:
                                if (bottomList.length >= 7) {
                                  text = DateFormat('M/dd')
                                      .format(DateTime.parse(bottomList[6]))
                                      .toString();
                                } else {
                                  text = '';
                                }
                                break;
                            }

                            return Text(text);
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        axisNameWidget: Text(
                          "【血糖値】",
                          style: TextStyle(
                            color: Color(0xff68737d),
                          ),
                        ),
                        axisNameSize: 22.0,
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 25.0,
                          reservedSize: 40.0,
                        ),
                      ),
                      //上と右は無くそうかなーくらいの感じ。
                      rightTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles:
                          AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    maxY: 200,
                    minY: 0,
                  ),
                ),
              );
            } catch (e) {
              print(e);
              return Text("load");
            }
          }
          return Text("loading");
        });
  }
}

AxisTitles get _bottomTitles => AxisTitles(
      axisNameWidget: Text(
        "【計測回数】",
        style: TextStyle(
          color: Color(0xff68737d),
        ),
      ),
      axisNameSize: 22.0,
      sideTitles: SideTitles(
        showTitles: true,
        interval: 1.0,
        reservedSize: 40.0,
        getTitlesWidget: (value, meta) {
          String text = '';

          switch (value.toInt()) {
            case 0:
              text = '00/00';
              break;
            case 1:
              text = '6';
              break;
            case 2:
              text = '5';
              break;
            case 3:
              text = '4';
              break;
            case 4:
              text = '3';
              break;
            case 5:
              text = '2';
              break;
            case 6:
              text = 'last';
              break;
          }

          return Text(text);
        },
      ),
    );
