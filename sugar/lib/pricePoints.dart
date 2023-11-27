import 'dart:collection';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sugar/firebase/db.dart';

class PricePoint {
  final double x;
  final double y;

  PricePoint({required this.x, required this.y});
}

List<PricePoint> get pricePoints {
  //print(DateTime.now());
  final service = FirebaseService();

  final map;

  final data = [98, 120, 67, 78, 89, 56, 100];

  return data
      .mapIndexed(((index, element) =>
          PricePoint(x: index.toDouble(), y: element.toDouble())))
      .toList();
}
