import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      targetCert = data.certObj.first;
    }

    studyTimeWidget = StudyTimeBox(targetCert);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('학습관리 페이지'),
        ), //title 용
        drawer: StudySetting(),
//        bottomNavigationBar:
        body: Row(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text('D-${(targetCert.getRemainingDate() == -99 ? "NULL" : targetCert.getRemainingDate()) } '),
                    constraints: BoxConstraints(
                        maxWidth: 80, minWidth: 80, maxHeight: 80, minHeight: 80),
                    color: Colors.white70,
                    alignment: AlignmentDirectional(0, 0),
                  ),
                  //D-day를 위한 container 박스 크기를 결정하여 높이를 조절함(바꿀 예정, + 더좋은게 있다면 바꿔주세요) 넣어둠.
                  SizedBox(
                    height: 20,
                  ),
                  //D-day 박스와 그 아래 박스의 공간을 주기 위함.
                  Container(
                    child: Text('${targetCert.CertName}'),
                    constraints: BoxConstraints(
                        maxWidth: 300, minWidth: 300, maxHeight: 60, minHeight: 60),
                    color: Colors.white70,
                    alignment: AlignmentDirectional(0, 0),
                  ),
                  //D-day랑 똑같은 방식 여기는 testName
                  SizedBox(
                    height: 20,
                  ),
                  // 위에랑 똑같은 이유
                  studyTimeWidget,
                  MaterialButton(
                    onPressed: () =>{ Navigator.of(context).pushNamed(TIME_SETTING_PAGE)},
                    child: Text("학습시간 입력"),
                  ),
                ],
              ),
            ),
          ],
        )
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

  StudyTimeBox(this.targetCert) { state = StateStudyTimeBox(this.targetCert); }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return state;
  }

}

class StateStudyTimeBox extends State<StudyTimeBox> {
  Firestore firestore;
  CertObjective targetCert;
  int studyTime;

  StateStudyTimeBox(this.targetCert);

  String compareText() {
    String messege;
    if (targetCert.averageTime == null) {
      messege = "데이터를 가져오는 중입니다";
    }
    else if ((targetCert.averageTime) >= (targetCert.getWeekAverage())) {
      messege = "공부 시간이 부족합니다";
    } else {
      messege = "공부 시간이 평균 이상입니다";
    }
    return messege;
  }

  void updateStat() {
    setState(() {studyTime = targetCert.getWeekAverage(); } );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    firestore = Firestore.instance;
    firestore
        .collection('CertPrepareData')
        .document('FirstClient')
        .setData({'studytime': targetCert.getWeekAverage()});
    firestore
        .collection('CertPrepareData')
        .document('TotalAverage')
        .get()
        .then((DocumentSnapshot ds) {
      setState(() {
        targetCert.averageTime = ds.data['studytime'];
      });
    });

    studyTime = targetCert.getWeekAverage();

    return Column(
        children: <Widget>[
          Container(
            child: Text(
              '당신의 ${DateTime
                  .now()
                  .month}월 ${DateTool.getWeek()}주의 공부시간은',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            constraints: BoxConstraints(
                maxWidth: 300, minWidth: 300, maxHeight: 60, minHeight: 60),
            color: Colors.white70,
            alignment: AlignmentDirectional(0, 0),
          ),
          //위에랑 똑같은 이유
          Container(
            child: Text(
              '${studyTime}시간 입니다!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            constraints: BoxConstraints(
                maxWidth: 300, minWidth: 300, maxHeight: 80, minHeight: 80),
            color: Colors.white70,
            alignment: AlignmentDirectional(0, 0),
          ),
          //위에랑 똑같은 이유

          Container(
            child: Text(
              '다른 사람의 주당 학습 시간은 ${targetCert.averageTime} 시간입니다',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            constraints: BoxConstraints(
                maxWidth: 300, minWidth: 300, maxHeight: 80, minHeight: 80),
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