import 'package:flutter/material.dart';

Map<String, Widget> profile = {
  'ニックネーム': const Text('けいた', style: TextStyle(fontSize: 20)),
  'プロフィール画像': CircleAvatar(),
  '性別': const Text('男', style: TextStyle(fontSize: 20)),
  '平均血糖値': const Text('100mg/dl', style: TextStyle(fontSize: 20)),
  '目標血糖値': const Text('90mg/dl', style: TextStyle(fontSize: 20)),
  '血圧': const Text('90mmHg', style: TextStyle(fontSize: 20)),
};
