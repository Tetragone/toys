import 'package:flutter/material.dart';

import 'page_study_manage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: StudyManager(title: '학습 관리'),
    );
  }
}
