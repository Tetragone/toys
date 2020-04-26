import 'package:flutter/material.dart';

class StudyTimeCheckAndCompare extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공부 시간 확인 및 비교'),),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text('back'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}