import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mycerthelper/page_study_manage.dart';

class Data {
  static List<CertObjective> certObj = new List();
  static bool initiated = false;

  static CertObjective getCertObjByName(String name) {
    Iterator<CertObjective> cursor;
    cursor = certObj.iterator;
    while(cursor.moveNext() == true) {
      if(cursor.current.CertName == name)
        return cursor.current;
    }
    return null;
  }

  void testMode() {
    CertObjective testData = CertObjective();
    //testData.buildTestData();
    certObj.add(testData);
  }

  Future<bool> init() async {
    FirebaseUser qID;
    QuerySnapshot qSnap;
    Firestore store = Firestore.instance;
    Iterator<DocumentSnapshot> docIter;
    DocumentSnapshot cursor;
    CertObjective objective;

    qID = await FirebaseAuth.instance.currentUser();
    qSnap = await store.collection('/ObjectList').where('user', isEqualTo: qID.email).getDocuments();

    if(qSnap.documents != null) {
      docIter = qSnap.documents.iterator;

      while (docIter.moveNext() == true) {
        cursor = docIter.current;
        objective = CertObjective();
        objective.CertName = cursor['certName'];
        objective.selected = Color(int.parse(cursor['color']));
        objective.isTested = cursor['isTested'] == 'true' ? true : false;
        objective.priority = int.parse(cursor['priority']);
        objective.targetGrade = int.parse(cursor['targetGrade']);
        objective.classificationName = cursor['classification'];
        objective.organizerName = cursor['organizer'];

        Data.certObj.add(objective);
      }

      StudyManagerState.targetCert = Data.certObj.first;
    }
    initiated = true;

    return true;
  }


}

class CertObjective {
  String CertName;
  int priority;
  int targetGrade = -1;
  bool isTested;
  Color selected;
  List<DateTime> examDate = List<DateTime>();
  List<StudyTime> personalTime = List<StudyTime>();
  int averageTime;
  String classificationName;
  String organizerName;
  int goalTime = 0;
  int goalWeek = 0;
  bool uploaded = false;

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
    CertName = "자격증을 입력해 주세요!";
    priority = 1;
    targetGrade =  -1;
    isTested = false;
    selected = Colors.red;

    DateTime dummyDate = DateTime.now();
    dummyDate = dummyDate.add(new Duration(days: 17));

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
//      personalTime.add(dummyTime);
    }
  }

  int getRemainingDate() {
    int diff = 0;
    DateTime now = DateTime.now();
    if(examDate.isEmpty == true)
      return -99;
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
      if(cursor.startTime.isAfter(checker) || cursor.startTime.difference(checker).inSeconds == 0)
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
    String timeString;
    time = time.subtract(new Duration(days: (time.weekday - 1)));
    time = new DateTime(time.year, time.month, time.day);
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
    dateGap = DateTime
        .now()
        .difference(time)
        .inDays;
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