import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:mycerthelper/main.dart';
import 'data_group.dart';
import 'page_study_menu_bar.dart';

// 코드를 좀더 가독성 있게 바꿀 예정이에요!
class StudyManager extends StatefulWidget {
  static StudyManagerState state;
  StudyManager(){ state =  StudyManagerState();}
  @override
  State createState() { state= StudyManagerState(); return state; }
}

class StudyManagerState extends State<StudyManager> {
  static Data data;
  static CertObjective targetCert;
  Firestore firestore;
  StudyTimeBox studyTimeWidget;

  @override
  void initState() {
    if(data == null) {
      data = Data();
      data.testMode();
      targetCert = Data.certObj.first;
    }

    studyTimeWidget = StudyTimeBox(targetCert);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('학습관리'),
        ), //title 용
        drawer: StudySetting(),
//        bottomNavigationBar:
        body: SingleChildScrollView(
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                          'D-${(targetCert.getRemainingDate() == -99 ? "시험 일정 없음" : targetCert.getRemainingDate()) } ',
                        style: TextStyle(
                          fontSize: 40
                        ),
                      ),
                      constraints: BoxConstraints(
                          maxHeight: 80, minHeight: 80),
                      color: Colors.white70,
                      alignment: AlignmentDirectional(0, 0),
                    ),//d-day나오는 박스
                    //D-day 박스와 그 아래 박스의 공간을 주기 위함.
                    Container(
                      child: Text('${targetCert.CertName}'),
                      constraints: BoxConstraints(
                          maxWidth: 100, minWidth: 100, maxHeight: 60, minHeight: 60),
                      color: Colors.white70,
                      alignment: AlignmentDirectional(0, 0),
                    ), //시험 이름이 나오는 박스
                    studyTimeWidget,
                    MaterialButton(
                      onPressed: () =>{ Navigator.of(context).pushNamed(TIME_SETTING_PAGE)},
                      child: Text("학습시간 입력"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }

  void updateStat(){
    setState(() {
      StudyTimeBox.state.updateStat();
    });
  }
}

class StudyTimeBox extends StatefulWidget {

  String messege;
  CertObjective targetCert;
  static StateStudyTimeBox state;

  StudyTimeBox(this.targetCert) { state = StateStudyTimeBox(); }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return state;
  }

}

class StateStudyTimeBox extends State<StudyTimeBox> {
  Firestore firestore;
  int studyTime;

  StateStudyTimeBox();

  String compareText() {
    String messege;
    if (StudyManagerState.targetCert.averageTime == null) {
      messege = "데이터를 가져오는 중입니다";
    }
    else if ((StudyManagerState.targetCert.averageTime) >= (StudyManagerState.targetCert.getWeekAverage())) {
      messege = "공부 시간이 부족합니다";
    } else {
      messege = "공부 시간이 평균 이상입니다";
    }
    return messege;
  }

  void updateStat() {
    setState(() {
      studyTime = StudyManagerState.targetCert.getWeekAverage();
    } );
  }

  Color destinColors(int studyTime){
    if(StudyManagerState.targetCert.averageTime == null)
      return Colors.grey;

    if(studyTime > StudyManagerState.targetCert.averageTime / 7)
      return Colors.blue;
    else return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    DateTime thisWeekMonday = DateTool.getWeekMonday(DateTime.now());


    var data = [
      new barChartContexts('월요일', StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday)
          ,destinColors(StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday))),
      new barChartContexts('화요일', StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 1)))
         ,destinColors(StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 1))))),
      new barChartContexts('수요일', StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 2)))
          ,destinColors(StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 2))))),
      new barChartContexts('목요일', StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 3)))
          ,destinColors(StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 3))))),
      new barChartContexts('금요일', StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 4)))
          ,destinColors(StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 4))))),
      new barChartContexts('토요일', StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 5)))
          ,destinColors(StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 5))))),
      new barChartContexts('일요일', StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 6)))
          ,destinColors(StudyManagerState.targetCert.getPersonalTimeWithDate(thisWeekMonday.add(Duration(days: 6)))))
    ];

    var dataHori = [
      new horizontalChartContexts(StudyManagerState.targetCert.getWeekAverage(), '내 주간 공부 시간'),
      new horizontalChartContexts(StudyManagerState.targetCert.averageTime, '다른 사람 평균 주간 공부 시간')
    ];

    var series = [
      new charts.Series(
          id: 'studytime',
          domainFn: (barChartContexts clickData, _) => clickData.weekend,
          measureFn: (barChartContexts clickData, _) => clickData.studyTime,
          colorFn: (barChartContexts clickData, _) => clickData.color,
          data: data
      )
    ];

    var seriesHori = [
      new charts.Series(
          id: 'studytime',
          domainFn: (horizontalChartContexts clickData, _) => clickData.person,
          measureFn: (horizontalChartContexts clickData, _) => clickData.studytime,
          data: dataHori,
          labelAccessorFn: (horizontalChartContexts clickData, _) =>
              '${clickData.person}: \$${clickData.studytime.toString()}',
      )
    ];

    var chart = new charts.BarChart(
      series,
      animate: true,
    );

    var chartHori = new charts.BarChart(
      seriesHori,
      animate: true,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
    // Hide domain axis.
      domainAxis:
          new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );

    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

    var chartHoriWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chartHori,
      ),
    );



    firestore = Firestore.instance;
    firestore
        .collection('CertPrepareData')
        .document('FirstClient')
        .setData({'studytime': StudyManagerState.targetCert.getWeekAverage()});
    firestore
        .collection('CertPrepareData')
        .document('TotalAverage')
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        StudyManagerState.targetCert.averageTime = ds.data['studytime'];
      });
    });

    studyTime = StudyManagerState.targetCert.getWeekAverage();

    return Column(
        children: <Widget>[
          Container(
            child: Text(
              '목표 점수: ${ (StudyManagerState.targetCert.targetGrade < 0) ? "설정이 필요합니다" : StudyManagerState.targetCert.targetGrade }',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            color: Colors.white70,
            alignment: AlignmentDirectional(0, 0),
          ),
          Container(
            child: Text(
              '${DateTime
                  .now()
                  .month}월 ${DateTool.getWeek()}주차',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            color: Colors.white70,
            alignment: AlignmentDirectional(0, 0),
          ),
          //위에랑 똑같은 이유
          Container(
            child: Text(
              '주간 공부 시간은 ${studyTime}시간 입니다!',
             style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            color: Colors.white70,
            alignment: AlignmentDirectional(0, 0),
          ),
          //위에랑 똑같은 이유
          Container(
            child: chartWidget,
          ),
          Container(
            child: chartHoriWidget,
          ),
          Container(
            child: Text(
              '다른 사람의 주간 공부 시간 : ${StudyManagerState.targetCert.averageTime}',
             style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            constraints: BoxConstraints(
                maxHeight: 50, minHeight: 40),
            color: Colors.white70,
            alignment: AlignmentDirectional(0, 0),
          ),
          Container(
              child: Text(
                compareText(),
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              constraints: BoxConstraints(
                  maxWidth: 300, minWidth: 300, maxHeight: 80, minHeight: 80),
              color: Colors.white70,
              alignment: AlignmentDirectional(0, 0)
          )
       ]
    );
  }
}


class barChartContexts{
  final String weekend;
  final int studyTime;
  final charts.Color color;

  barChartContexts(this.weekend, this.studyTime, Color color)
      : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class horizontalChartContexts {
  final int studytime;
  final String person;
  
  horizontalChartContexts(this.studytime, this.person);
}