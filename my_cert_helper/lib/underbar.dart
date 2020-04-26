import 'package:flutter/material.dart';

class UnderBar extends StatefulWidget{

  @override
  State createState() => UnderBarState();
}

class UnderBarState extends State<UnderBar>{

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RaisedButton(
          child: Text('메인'),
          onPressed: () => {},
          padding: EdgeInsets.fromLTRB(28.5, 0, 28.5, 0),
        ),
        RaisedButton(
          child: Text('학습 관리'),
          onPressed: () => {},
          padding: EdgeInsets.fromLTRB(28.5, 0, 28.5, 0),
        ),
        RaisedButton(
          child: Text('캘린더'),
          onPressed: () => {},
          padding: EdgeInsets.fromLTRB(28.5, 0, 28.5, 0),
        ),
        RaisedButton(
          child: Text('정보 설정'),
          onPressed: () => {},
          padding: EdgeInsets.fromLTRB(28.5, 0, 28.5, 0),
        ),
      ],
    );
  }
}