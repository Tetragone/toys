import 'package:flutter/material.dart';

class TestSettingPage extends StatefulWidget{

  @override
  State createState() => TestSettingPageState();
}

class TestSettingPageState extends State<TestSettingPage>{

  @override
  Widget build(BuildContext context ){
    return Scaffold(
        appBar: AppBar(title: Text('응시 자격증 설정'),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            RaisedButton(
              child: Text('back'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        )
    );
  }
}