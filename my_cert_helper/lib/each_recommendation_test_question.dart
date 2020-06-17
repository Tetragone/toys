import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mycerthelper/main.dart';

import 'data_group.dart';

class TestQuestion extends StatefulWidget {
  int selected;

  TestQuestion(int selected) {
    this.selected = selected;
  }

  @override
  State createState() => TestQuestionState(selected);
}

class TestQuestionState extends State<TestQuestion>{
  Firestore firestore = Firestore.instance;
  String testQuestion;
  static int nowHowMany = 0;
  String nextOrFinish = '다음';
  var qSnap;
  List<DocumentSnapshot> docList;
  Iterator<DocumentSnapshot> docIter;
  int _radioValue = 0;
  static int score;
  String answerTemp0;
  String answerTemp1;
  String answerTemp2;
  String answerTemp3;
  int selected;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  TestQuestionState(int selected){
    this.selected = selected;
  }

  void showNextQuestion(){
    if(_radioValue == 0){
      score += 5;
    }
    else if(_radioValue == 1) {
      score += 3;
    }
    else if(_radioValue == 2) {
      score += 1;
    }
    else if(_radioValue == 3) {
      score += 0;
    }

    return setState(() {
      nowHowMany++;

      if(docIter.moveNext() == true){

        testQuestion = docIter.current.data["question"];
        answerTemp0 = docIter.current.data["answer0"];
        answerTemp1 = docIter.current.data["answer1"];
        answerTemp2 = docIter.current.data["answer2"];
        answerTemp3 = docIter.current.data["answer3"];

        _radioValue = 1;
        _radioValue = 0;
      }
      else {
        Navigator.of(context).pushNamed(ALL_RECOMMENDATION_QUESTION);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    nowHowMany = 0;
    score = 0;

    // 처음의 질문 값을 넣어줘야한다.
  }

  getFirestoreDocuments() async{
    return this._memoizer.runOnce(() async{
      if(Data.certObj.elementAt(selected).classificationName == '어학'){
        qSnap = await firestore.collection("RecommedationQuestionForLanguage").getDocuments();
      }
      else if(Data.certObj.elementAt(selected).classificationName == '사회'){
        qSnap = await firestore.collection("RecommedationQuestionForSocial").getDocuments();
      }
      else {
        qSnap = await firestore.collection("RecommedationQuestionForEngineering").getDocuments();
      }

      docList = qSnap.documents;
      docIter = docList.iterator;

      docIter.moveNext();

      testQuestion = docIter.current.data["question"];
      answerTemp0 = docIter.current.data["answer0"];
      answerTemp1 = docIter.current.data["answer1"];
      answerTemp2 = docIter.current.data["answer2"];
      answerTemp3 = docIter.current.data["answer3"];

      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공부 방법 추천 질문'),),
      body: FutureBuilder(
        future: getFirestoreDocuments(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false)
            return CircularProgressIndicator(); //위치 중앙으로 바꾸기
          else {
            return  SingleChildScrollView(
                child: Column(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: (int value) {
                              setState(() {
                                _radioValue = value;
                              });
                            }
                        ),
                        Text("$answerTemp0"),
                        Radio(
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: (int value) {
                              setState(() {
                                _radioValue = value;
                              });
                            }
                        ),
                        Text("$answerTemp1"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                            value: 2,
                            groupValue: _radioValue,
                            onChanged: (int value) {
                              setState(() {
                                _radioValue = value;
                              });
                            }
                        ),
                        Text("$answerTemp2"),
                        Radio(
                            value: 3,
                            groupValue: _radioValue,
                            onChanged: (int value) {
                              setState(() {
                                _radioValue = value;
                              });
                            }
                        ),
                        Text("$answerTemp3"),
                      ],
                    ),
                    RaisedButton(
                      child: Text('$nextOrFinish'),
                      onPressed: showNextQuestion,
                    )
                  ],
                )
            );
          }
        },
      )
    );
  }
}
