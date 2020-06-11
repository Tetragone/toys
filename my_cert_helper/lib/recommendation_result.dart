import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecommendationResult extends StatefulWidget {
  int score;
  List<int> answerSet;

  RecommendationResult(int score, List<int> answerSet) {
    this.score = score;
    this.answerSet = answerSet;
  }

  @override
  State createState() => RecommendationResultState(score, answerSet);
}

class RecommendationResultState extends State<RecommendationResult> {
  int score;  // 앞에서 본 시험의 점수
  num weekendStudyTime; //이름을 잘못 지음 총 공부 시간
  int studyStartWeek; //몇주 전부터 시험준비 하는지
  String ment; // 없으면 어색한 멘트
  List<int> answerSet; // 개념 : 0 문제 : 1 벼락 : 0 분산 : 1

  RecommendationResultState(int score, List<int> answerSet){
    this.score = score;
    this.answerSet = answerSet;
  }

  @override
  void initState() {
    super.initState();

    if(score >= 30) {
      weekendStudyTime = 30;
      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '시험 보기전에 관련서적 1개로 공부하면서 모의고사를 풀어보죠!';
        studyStartWeek = 1;
        weekendStudyTime *= 1.2;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '시험 보기전에 모의고사만 열심히 풀어요!';
        studyStartWeek = 1;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 조금씩 시험 볼때가지 관련 서적1개와 모의고사를 풀어보아요!';
        studyStartWeek = 2;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 조금씩 모의고사를 풀어보아요!';
        studyStartWeek = 1;
      }
    } // 30점 종료
    else if(score >= 25) {
      weekendStudyTime = 60;
      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '시험 보기전에 관련서적 1개로 공부하면서 모의고사를 풀어보아요!';
        studyStartWeek = 2;
        weekendStudyTime *= 1.2;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '시험 보기전에 모의고사만 열심히 풀어보아요!';
        studyStartWeek = 1;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 조금씩 시험 볼때가지 관련 서적1개와 모의고사를 풀어보아요!';
        studyStartWeek = 3;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 조금씩 모의고사를 풀어보아요!';
        studyStartWeek = 2;
      }
    } // 25점 완료
    else if(score >= 20) {
      weekendStudyTime = 90;
      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '시험 보기전에 관련 서적 여러개로 개념을 완벽히하고 모의고사를 풀어보아요!';
        studyStartWeek = 2;
        weekendStudyTime *= 1.2;
        weekendStudyTime *= 1.2;

      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '시험 보기전에 관련 서적 1개로 개념을 상기하고 모의고사를 많이 풀어서 준비해요!';
        studyStartWeek = 2;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 꾸준히 관련 서적 여러개로 개념을 완벽히하고 모의고사를 천천히 풀어보아요!';
        studyStartWeek = 4;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 꾸준히  관련 서적 1개로 개념을 익히고 모의고사를 통해 개념을 적용시켜요!';
        studyStartWeek = 3;
      }
    } //20점 완료
    else if(score >= 15) {
      weekendStudyTime = 120;
      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '시험 보기전에 관련 서적 여러개로 개념을 완벽히하고 모의고사를 풀어보아요!';
        studyStartWeek = 3;
        weekendStudyTime *= 1.2;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '시험 보기전에 관련 서적 1개로 개념을 상기하고 모의고사를 많이 풀어서 준비해요!';
        studyStartWeek = 2;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 꾸준히 관련 서적 여러개로 개념을 완벽히하고 모의고사를 천천히 풀어보아요!';
        studyStartWeek = 5;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 꾸준히  관련 서적 1개로 개념을 익히고 모의고사를 통해 개념을 적용시켜요!';
        studyStartWeek = 4;
      }
    } //15점 완료
    else if(score >= 10) {
      weekendStudyTime = 150;
      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 3;
        weekendStudyTime *= 1.2;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 3;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡으면서 배운 개념을 적용시킬 수 있는 문제를 풀어보아요!';
        studyStartWeek = 7;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡아가요!';
        studyStartWeek = 6;
      }
    } //10점 완료
    else if(score >= 5) {
      weekendStudyTime = 180;
      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 4;
        weekendStudyTime *= 1.2;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 3;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡으면서 배운 개념을 적용시킬 수 있는 문제를 풀어보아요!';
        studyStartWeek = 8;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡아가요!';
        studyStartWeek = 7;
      }
    } //5점 완료
    else {
      weekendStudyTime = 210;
      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 5;
        weekendStudyTime *= 1.2;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 4;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡으면서 배운 개념을 적용시킬 수 있는 문제를 풀어보아요!';
        studyStartWeek = 9;
        weekendStudyTime *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡아가요!';
        studyStartWeek = 8;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공부방법 추천 결과'),),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "당신의 점수는 $score점입니다!",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              padding: EdgeInsets.all(20),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "목표 시간 ${weekendStudyTime.toStringAsFixed(2)}시간에",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '도달하기 위해',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "주당 ${(weekendStudyTime/studyStartWeek).toStringAsFixed(2)}시간을",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "$studyStartWeek주전부터 공부해야 합니다!",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.all(40),
            ),

            Text(
              "$ment",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        )
      ),
    );
  }
}