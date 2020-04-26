import 'package:flutter/material.dart';

import 'page_study_manage.dart';

//TODO
// 1) 응시 자격증 출력
//2) 공부 시간 기록
//3) 공부 시간 비교
//4) 자격증 합격 예측

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Data data = Data();
    data.testMode();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: StudyManager('학습 관리', data),
    );
  }
}

class Data {
  List<CertObjective> certObj = new List();

  void testMode() {
    CertObjective testData = CertObjective();
    testData.buildTestData();
    certObj.add(testData);
  }
}

class CertObjective {
  int CertID;
  String CertName;
  int priority;
  int targetScore;
  int targetGrade;
  bool isTested;
  Color selected;
  List<DateTime> examDate = List<DateTime>();
  List<StudyTime> personalTime = List<StudyTime>();
  int averageTime;

  CertObjective();

  int getPersonalTimeWithDate(DateTime date) {
    int sum = 0;
    Iterator<StudyTime> iter = personalTime.iterator;
    while(iter.moveNext() != false) {
      if( ( date.day == iter.current.startTime.day ) && ( date.month == iter.current.startTime.month ) && ( date.year == iter.current.startTime.year ) )
        sum = -1 * (sum + iter.current.startTime.difference(iter.current.endTime).inHours);
    }
    return sum;
  }

  void modifyPersonalTimeWithDate(DateTime date, int amount) {
    Iterator<StudyTime> iter = personalTime.iterator;
    DateTime cursor;
    while(iter.moveNext() != false) {
      cursor = iter.current.startTime;
      if( ( date.day == cursor.day ) && ( date.month == cursor.month ) && ( date.year == cursor.year ) )
        iter.current.endTime = iter.current.endTime.add(new Duration(hours: amount ));
    }
  }

  CertObjective buildTestData() {
    CertID = 101;
    CertName = "testCert";
    priority = 1;
    targetScore = -1;
    targetGrade = 1;
    isTested = false;
    selected = Colors.red;

    DateTime dummyDate = DateTime.now();
    dummyDate = dummyDate.add(new Duration(days: 17));
    examDate.add(dummyDate);

    DateTime startTime;
    DateTime endTime;
    StudyTime dummyTime;
    String parse;
    for(int count = 0; count < 14; count++) {
      parse = DateTime.now().subtract(new Duration(days: (14 - count) ) ).toString().substring(0,10);
      startTime= DateTime.parse(parse);
      parse = DateTime.now().subtract(new Duration(days: (14 - count) ) ).toString().substring(0,10);
      endTime = DateTime.parse(parse).add(new Duration(hours:9));
      dummyTime = new StudyTime(startTime, endTime);
      personalTime.add(dummyTime);
    }
  }

  int getRemainingDate() {
    int diff = 0;
    DateTime now = DateTime.now();
    diff = examDate.first.difference(now).inDays;
    return diff;
  }

  int getWeekAverage() {
    Iterator iterator = personalTime.iterator;
    DateTime checker = DateTool.getWeekMonday(DateTime.now());
    Duration sum = Duration();
    StudyTime cursor;

    while(iterator.moveNext() != false) {
      cursor = iterator.current;
      if(cursor.startTime.day >= checker.day)
        sum = sum + cursor.startTime.difference(cursor.endTime);
    }

    return ((sum.inHours).toInt() * -1);

  }

}

class StudyTime {
  DateTime startTime;
  DateTime endTime;

  StudyTime(this.startTime, this.endTime);
}

class DateTool {
  static DateTime getWeekMonday(DateTime time) {
    time = time.subtract(new Duration(days: (time.weekday - 1) ) );
    return time;
  }

  static int getWeek() {
    //TODO
    DateTime time = DateTime.now();
    double diff = 0;
    int dateGap = 0;
    String timeString = getDayOne();
    time = DateTime.parse(timeString);
    time = getWeekMonday(time);
    dateGap = DateTime.now().difference(time).inDays;
    diff = dateGap / 7;

    return diff.ceil();
  }

  static String getDayOne() {
    DateTime time = DateTime.now();
    String timeString = time.toString().substring(0, 7);
    timeString = timeString + '01';
    return timeString;
  }
}