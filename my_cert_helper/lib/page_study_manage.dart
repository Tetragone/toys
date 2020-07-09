import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:mycerthelper/main.dart';
import 'calendar_page.dart';
import 'data_group.dart';
import 'page_study_menu_bar.dart';

// 코드를 좀더 가독성 있게 바꿀 예정이에요!
class StudyManager extends StatefulWidget {
  static StudyManagerState state;

  StudyManager() {
    state = StudyManagerState();
  }

  @override
  State createState() {
    state = StudyManagerState();
    return state;
  }
}

class StudyManagerState extends State<StudyManager> {
  static Data data;
  static CertObjective targetCert;
  Firestore firestore;
  StudyTimeBox studyTimeWidget;
  bool isDataLoaded;
  List<String> weekday = ['월', '화', '수', '목', '금', '토', '일'];
  List<int> inputList = List();
  Iterator<DocumentSnapshot> docIter;
  DateTime inputStudyTimeDay = DateTool.getWeekMonday(DateTime.now());

  getStudyTime() async {
    DateTime tempDateTime;

    if (data == null) {
      data = Data();
      //data.testMode();
      if (Data.certObj.length != 0)
        targetCert = Data.certObj.first;
    }

    if(Data.initiated == false)
      isDataLoaded = await data.init();

    if (targetCert.uploaded == true)
      return true;

    await Firestore.instance.collection('ObjectList')
        .where('certName', isEqualTo: targetCert.CertName)
        .where('user', isEqualTo: CalenderPage.emailID).getDocuments()
        .then((QuerySnapshot qs) {
      docIter = qs.documents.iterator;

      if(docIter.moveNext() == true){ // 초기화가 되어 있는지 확인하고 한다.
        if (docIter.current.data['standardDay'] == inputStudyTimeDay.toString()) {
          for(int i = 0; i < 7; i++) {
            String tempString = docIter.current.data['${weekday[i]}'];
            int temp = int.parse(tempString);

            tempDateTime = inputStudyTimeDay.add(Duration(days: i));
            targetCert.personalTime.add(new StudyTime(tempDateTime, tempDateTime.add(Duration(hours: temp))));
            print('${targetCert.getPersonalTimeWithDate(tempDateTime)}');
          }
        }
        else {
          for(int i = 0; i < 7; i++) {
            tempDateTime = inputStudyTimeDay.add(Duration(days: i));
            targetCert.personalTime.add(new StudyTime(tempDateTime, tempDateTime.add(Duration(hours: 0))));
          }
        }

        targetCert.uploaded = true;
      }
    });
    return true;
  } // 데이터를 가져오는 부분 (주간 공부 시간을 가져오는 부분)


  @override
  void initState() {
    if (data == null) {
      data = Data();
      //data.testMode();
      if (Data.certObj.length != 0)
        targetCert = Data.certObj.first;
    }

    studyTimeWidget = StudyTimeBox(targetCert);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold
      (
        appBar: AppBar(
          title: Text('학습관리'),
        ), //title 용
        drawer: StudySetting(),
//        bottomNavigationBar:
        body: FutureBuilder(
            future: getStudyTime(),
            builder: (context, snapshot) {
              SingleChildScrollView first;
              if(snapshot.hasData == true) {
                return
                  SingleChildScrollView(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 10,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text( (targetCert.getRemainingDate() == -99 ? "시험 일정 없음" : 'D- ${targetCert.getRemainingDate()}' ),
                                  style: TextStyle(
                                      fontSize: 40
                                  ),
                                ),
                                constraints: BoxConstraints(
                                    maxHeight: 80, minHeight: 80),
                                color: Colors.white70,
                                alignment: AlignmentDirectional
                                  (0, 0),
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
                  );

              }

              else {
                return Text("정보를 가져오는 중입니다");
              }
            }
        ));

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

} // 공부 시간 비교를 위한 class 이고 내용은 state에 있음.

class StateStudyTimeBox extends State<StudyTimeBox> {
  Firestore firestore;
  int studyTime;
  int averageTime;
  String printCompareGoal;
  Iterator<DocumentSnapshot> docIter;
  DateTime thisWeekMonday = DateTool.getWeekMonday(DateTime.now());
  List<String> weekday = ['월', '화', '수', '목', '금', '토', '일'];

  StateStudyTimeBox();

  String compareText() {
    String message;

    if (StudyManagerState.targetCert.goalTime == 0)
    {
      if (StudyManagerState.targetCert.averageTime == null) {
        message = "데이터를 가져오는 중입니다";
      }
      else {
        averageTime = StudyManagerState.targetCert.averageTime;

        if (averageTime >= (StudyManagerState.targetCert.getWeekAverage())) {
          message = "공부 시간이 부족합니다";
        } else {
          message = "공부 시간이 평균 이상입니다";
        }
      }
    }
    else { // 목표 시간에 따른 공부 시간 알려주기 위한 코드
      averageTime = StudyManagerState.targetCert.goalTime ~/ StudyManagerState.targetCert.goalWeek;
      // ~/ 가 / .toInt()보다 효율적.
      if (StudyManagerState.targetCert.averageTime == null) {
        message = "데이터를 가져오는 중입니다";
      }
      else {
        studyTime = StudyManagerState.targetCert.getWeekAverage();
        if(averageTime >= studyTime)
          message = "공부 시간이 부족합니다";
        else {
          message = '공부 시간이 평균 이상입니다';
        }
      }
    }

    return message;
  }

  @override
  void initState() {
    super.initState();

    if (StudyManagerState.targetCert.goalTime == 0) {
      printCompareGoal = '다른 사람의 주간 공부 시간';
    }
    else {
      printCompareGoal = '나의 주간 목표 공부 시간';
    }
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

    //그래프를 만들기 위한 코드 여기부터~
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
    // 이부분을 고쳐야 어플 키면 적용 가능.
    // 1.여기서 가져온다.
    // 2.먼저 가져다 둔다.
    var dataHori = [
      new horizontalChartContexts(StudyManagerState.targetCert.getWeekAverage(), '내 주간 공부 시간'),
      new horizontalChartContexts(averageTime, '$printCompareGoal')
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

    // 그래프를 만들기 위한 코드 ~여기까지
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
              '주간 공부 시간은 $studyTime시간 입니다!',
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
              '$printCompareGoal : $averageTime',
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