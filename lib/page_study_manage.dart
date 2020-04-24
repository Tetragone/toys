import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 코드를 좀더 가독성 있게 바꿀 예정이에요!
class StudyManager extends StatelessWidget{

  int Dday = 5; //test data for D-day
  String testName = 'test'; //test data for testName
  int month = 5; // //test data for month
  int week = 1; //test data for week
  int studyTime = 20; //test data for study time

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('학습관리'),),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

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
                ), //D-day를 위한 container 박스 크기를 결정하여 높이를 조절함(바꿀 예정, + 더좋은게 있다면 바꿔주세요) 넣어둠.
                SizedBox(height: 20,), //D-day 박스와 그 아래 박스의 공간을 주기 위함.
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
                ),//D-day랑 똑같은 방식 여기는 testName
                SizedBox(height: 20,), // 위에랑 똑같은 이유
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
                ), //위에랑 똑같은 이유
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
                ), //위에랑 똑같은 이유
              ],
            ),
          )
        ],
      ),
    );
  }
}