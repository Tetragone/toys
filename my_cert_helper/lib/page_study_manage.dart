import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycerthelper/page_input_study_time.dart';
import 'main.dart';

// 코드를 좀더 가독성 있게 바꿀 예정이에요!
class StudyManager extends StatelessWidget {
  Data data;
  static CertObjective targetCert;
  Firestore firestore;
  final String title;
  StudyTimeBox studyTimeWidget;

  StudyManager(this.title, this.data) {
    targetCert = data.certObj.first;
    studyTimeWidget = StudyTimeBox(targetCert);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ), //title 용
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) => {},
          currentIndex: 0,
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('메인'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.border_color),
              title: Text('학습관리'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('캘린더'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('정보설정'),
            )
          ],
        ), //아래에 버튼 넣기를 좀더 좋은 방법을 찾아서 바꿧습니다!
        //아래의 네비게이션 버튼을 이용하여 화면 전환을 하는 방법입니다!
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text('D-${targetCert.getRemainingDate()} '),
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
              onPressed: () =>
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RouteGetStudyTime(this)))
              },
              child: Text("학습시간 입력"),
            ),
          ],
        ));
  }

    void updateStat(){
    StudyTimeBox.state.updateStat();
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