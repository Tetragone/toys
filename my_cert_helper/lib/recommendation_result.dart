import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycerthelper/page_study_manage.dart';
import 'package:mycerthelper/test_score_prediction.dart';

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
  int basicTime = 30;
  int multiValue;
  num multiValueForType = 1;
  List<String> recommendStudyWay = List();

  RecommendationResultState(int score, List<int> answerSet){
    this.score = score;
    this.answerSet = answerSet;
  }


  @override
  void initState() {

    if(StudyManagerState.data.certObj.elementAt(TestScorePrediction.selected).classificationName == '어학') {

    }
    else if (StudyManagerState.data.certObj.elementAt(TestScorePrediction.selected).classificationName == '사회') {

    }
    else {

    }

    recommendStudyWay.add("교재 연습 문제 풀기");
    recommendStudyWay.add("기출문제 활용");
    recommendStudyWay.add("블로그 활용");
    recommendStudyWay.add("강의 판서 따라적기");
    recommendStudyWay.add("교재의 문제 풀기");
    recommendStudyWay.add("기출문제 해설지 활용");
    recommendStudyWay.add("기출문제를 통한 개념 정리");
    recommendStudyWay.add("강의 복습");
    recommendStudyWay.add("개념 외우기");
    recommendStudyWay.add("교재 빈칸 채우기");
    recommendStudyWay.add("EBS 강의 수강");
    recommendStudyWay.add("강의 내용 요약하기");
    recommendStudyWay.add("선생님 되어 보기");
    recommendStudyWay.add("오답노트 활용");

    super.initState();

    if(score >= 30) {
      multiValue = 1;

      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '시험 보기전에 관련서적 1개로 공부하면서 모의고사를 풀어보죠!';
        studyStartWeek = 1;
        multiValueForType *= 1.2;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '시험 보기전에 모의고사만 열심히 풀어요!';
        studyStartWeek = 1;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 조금씩 시험 볼때가지 관련 서적1개와 모의고사를 풀어보아요!';
        studyStartWeek = 2;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 조금씩 모의고사를 풀어보아요!';
        studyStartWeek = 1;
      }


    } // 30점 종료
    else if(score >= 25) {
      multiValue = 2;

      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '시험 보기전에 관련서적 1개로 공부하면서 모의고사를 풀어보아요!';
        studyStartWeek = 2;
        multiValueForType *= 1.2;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '시험 보기전에 모의고사만 열심히 풀어보아요!';
        studyStartWeek = 1;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 조금씩 시험 볼때가지 관련 서적1개와 모의고사를 풀어보아요!';
        studyStartWeek = 3;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 조금씩 모의고사를 풀어보아요!';
        studyStartWeek = 2;
      }
    } // 25점 완료
    else if(score >= 20) {
      multiValue = 3;

      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '시험 보기전에 관련 서적 여러개로 개념을 완벽히하고 모의고사를 풀어보아요!';
        studyStartWeek = 2;
        multiValueForType *= 1.2;
        multiValueForType *= 1.2;

      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '시험 보기전에 관련 서적 1개로 개념을 상기하고 모의고사를 많이 풀어서 준비해요!';
        studyStartWeek = 2;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 꾸준히 관련 서적 여러개로 개념을 완벽히하고 모의고사를 천천히 풀어보아요!';
        studyStartWeek = 4;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 꾸준히  관련 서적 1개로 개념을 익히고 모의고사를 통해 개념을 적용시켜요!';
        studyStartWeek = 3;
      }
    } //20점 완료
    else if(score >= 15) {
      multiValue = 4;

      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '시험 보기전에 관련 서적 여러개로 개념을 완벽히하고 모의고사를 풀어보아요!';
        studyStartWeek = 3;
        multiValueForType *= 1.2;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '시험 보기전에 관련 서적 1개로 개념을 상기하고 모의고사를 많이 풀어서 준비해요!';
        studyStartWeek = 2;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 꾸준히 관련 서적 여러개로 개념을 완벽히하고 모의고사를 천천히 풀어보아요!';
        studyStartWeek = 5;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 꾸준히  관련 서적 1개로 개념을 익히고 모의고사를 통해 개념을 적용시켜요!';
        studyStartWeek = 4;
      }
    } //15점 완료
    else if(score >= 10) {
      multiValue = 5;

      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 3;
        multiValueForType *= 1.2;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 3;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡으면서 배운 개념을 적용시킬 수 있는 문제를 풀어보아요!';
        studyStartWeek = 7;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡아가요!';
        studyStartWeek = 6;
      }
    } //10점 완료
    else if(score >= 5) {
      multiValue = 6;

      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 4;
        multiValueForType *= 1.2;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 3;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡으면서 배운 개념을 적용시킬 수 있는 문제를 풀어보아요!';
        studyStartWeek = 8;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡아가요!';
        studyStartWeek = 7;
      }
    } //5점 완료
    else {
      multiValue = 7;

      if(answerSet[0] == 0 && answerSet[1] == 0){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 5;
        multiValueForType *= 1.2;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 0 && answerSet[1] == 1){
        ment = '지금부터 조금씩 조금씩 관련서적과 인강을 들으면서 개념을 다지고 시험보기 몇일전부터 모의고사와 개념을 같이 공부해요!';
        studyStartWeek = 4;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 0){
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡으면서 배운 개념을 적용시킬 수 있는 문제를 풀어보아요!';
        studyStartWeek = 9;
        multiValueForType *= 1.2;
      }
      else if(answerSet[0] == 1 && answerSet[1] == 1) {
        ment = '오늘부터 관련서적과 인강을 들으면서 개념을 잡아가요!';
        studyStartWeek = 8;
      }
    }

    weekendStudyTime = basicTime * multiValue * multiValueForType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공부방법 추천 결과'),),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
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
                          "목표 시간 ${weekendStudyTime.toStringAsFixed(0)}시간에",
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
                          "주당 ${(weekendStudyTime/studyStartWeek).toStringAsFixed(0)}시간을",
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
                  Container(
                    child: Text(
                      "$ment",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    padding: EdgeInsets.all(20),
                  ),
                ]
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    child: Text(
                      '${index + 1}. ${recommendStudyWay[index]}',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    padding: EdgeInsets.only(left: 20),
                  );
                },
                childCount: (multiValue * 2)
              ),
            )
          ],
        ),
      )
    );
  }
}
