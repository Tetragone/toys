import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycerthelper/main.dart';

class AllRecommendationQuestion extends StatefulWidget {
  int index;

  AllRecommendationQuestion(int index) {
    this.index = index;
  }
  @override
  State createState() => AllRecommendationQuestionState(index);

}

class AllRecommendationQuestionState extends State<AllRecommendationQuestion> {
  int radioValue = 0;
  String question = '공부 할때 어떤 방식을 선호 하시나요?';
  String answer0 = '개념 공부를 선호한다.';
  String answer1 = '문제 풀이를 선호한다. ';
  String nextOrFinish = '다음';
  static List<int> answerSet;
  int index;

  AllRecommendationQuestionState(int index) {
    this.index = index;
  }


  @override
  void initState() {
    super.initState();
    answerSet = List();
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
              '${index + 1}. $question',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            padding: EdgeInsets.all(20),
          ),
          ListTile(
            title: Text('$answer0'),
            leading: Radio(
              value: 0,
              groupValue: radioValue, //변수
              onChanged: (int value) {
                setState(() {
                  radioValue = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('$answer1'),
            leading: Radio(
              value: 1,
              groupValue: radioValue, //변수
              onChanged: (int value) {
                setState(() {
                  radioValue = value;
                });
              },
            ),
          ),
          RaisedButton(
            child: Text('$nextOrFinish'),
            onPressed: () {
              setState(() {
                if(nextOrFinish == '완료') {
                  answerSet.add(radioValue);
                  Navigator.of(context).pushNamed(RECOMMENDATION_RESULT);
                } else {
                  question = '공부습관이 어떻게 되시나요?';
                  answer0 = '벼락치기를 좋아한다.';
                  answer1 = '꾸준히 공부하는 편이다. ';
                  nextOrFinish = '완료';
                  answerSet.add(radioValue);
                  index++;
                }
              });
            },
          )
        ],
      ),
    );
  }


}