import 'package:flutter/material.dart';

import 'underbar.dart';

class StudyManager extends StatelessWidget{
  StudyManager({Key key, this.title}) : super(key: key);

  final String title;
  int Dday = 5;
  String testName = 'test';
  int month = 5;
  int week = 1;
  int studyTime = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Text('D-$Dday'),
            constraints: BoxConstraints(
              maxWidth: 80,
              minWidth: 80,
              maxHeight: 80,
              minHeight: 80
            ),
            color: Colors.white70,
            alignment: AlignmentDirectional(0,0),
          ),
          SizedBox(height: 20,),
          Container(
            child: Text('$testName'),
            constraints: BoxConstraints(
                maxWidth: 300,
                minWidth: 300,
                maxHeight: 60,
                minHeight: 60
            ),
            color: Colors.white70,
            alignment: AlignmentDirectional(0,0),
          ),
          SizedBox(height: 20,),
          Container(
            child: Text(
              '당신의 $month월 $week주의 공부시간은',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            constraints: BoxConstraints(
                maxWidth: 300,
                minWidth: 300,
                maxHeight: 60,
                minHeight: 60
            ),
            color: Colors.white70,
            alignment: AlignmentDirectional(0,0),
          ),
          Container(
            child: Text(
              '$studyTime시간 입니다!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            constraints: BoxConstraints(
                maxWidth: 300,
                minWidth: 300,
                maxHeight: 80,
                minHeight: 80
            ),
            color: Colors.white70,
            alignment: AlignmentDirectional(0,0),
          ),
          SizedBox(height: 235,),
          UnderBar(),
        ],
      )
    );
  }
}