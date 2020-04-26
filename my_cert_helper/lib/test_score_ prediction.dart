import 'package:flutter/material.dart';

class TestScorePrediction extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('자격증 점수 예측'),),
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