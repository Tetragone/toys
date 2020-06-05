import 'package:flutter/material.dart';

enum SingingCharacter { yes, no }

class TestQuestion extends StatefulWidget {
  @override
  State createState() => TestQuestionState();
}

class TestQuestionState extends State<TestQuestion>{
  String testQuestion;
  List<int> answer;
  SingingCharacter _character = SingingCharacter.yes;
  int nowHowMany = 0;
  String nextOrFinish;

  @override
  void initState() {
    if(nowHowMany < 15) {
      nextOrFinish = '다음';
    }
    else nextOrFinish = '종료';

    super.initState();

    testQuestion = '아직 질문이 없어요!';
    // 처음의 질문 값을 넣어줘야한다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공부 방법 추천 질문'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              '${nowHowMany + 1}. $testQuestion',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            padding: EdgeInsets.all(20),
          ),
          ListTile(
            title: Text('yes'),
            leading: Radio(
              value: SingingCharacter.yes,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),

          ListTile(
            title: const Text('no'),
            leading: Radio(
              value: SingingCharacter.no,
              groupValue: _character,
              onChanged: (SingingCharacter value) {
                setState(() {
                  _character = value;
                });
              },
            ),
          ),
          RaisedButton(
            child: Text('$nextOrFinish'),
            onPressed: showNextQuestion,
          )
        ],
      )
    );
  }

  void showNextQuestion(){
    if(_character == SingingCharacter.yes){
      answer[nowHowMany++] = 1;
    }
    else answer[nowHowMany++] = 0;

    setState(() {
      // 다음 질문의 값을 넣어줘야한다.
      testQuestion = '아직 질문이 없어요!';
    });
  }
}