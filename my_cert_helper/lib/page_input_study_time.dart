import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycerthelper/page_study_manage.dart';

import 'calendar_page.dart';
import 'data_group.dart';


class RouteGetStudyTime extends StatelessWidget{
  static List<StateStudyTimeForm> stateFormList = new List<StateStudyTimeForm>();
  List<String> weekday = ['월', '화', '수', '목', '금', '토', '일'];
  List<int> inputList = List();
  Iterator<DocumentSnapshot> docIter;
  DateTime inputStudyTimeDay = DateTool.getWeekMonday(DateTime.now());

  getStudyTime() async {
    DateTime tempDateTime;

    await Firestore.instance.collection('ObjectList')
        .where('certName', isEqualTo: StudyManagerState.targetCert.CertName)
        .where('user', isEqualTo: CalenderPage.emailID).getDocuments()
        .then((QuerySnapshot qs) {
       docIter = qs.documents.iterator;

       if(docIter.moveNext() == true){
         for(int i = 0; i < 7; i++) {
           int temp = docIter.current.data['${weekday[i]}'];
           inputList.add(temp);

           tempDateTime = inputStudyTimeDay.add(Duration(days: i));
           if(temp == null)
             StudyManagerState.targetCert.personalTime.add(new StudyTime(tempDateTime, tempDateTime.add(Duration(hours: 0))));
           else
             StudyManagerState.targetCert.personalTime.add(new StudyTime(tempDateTime, tempDateTime.add(Duration(hours: temp))));
         }
       }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('공부시간 입력')), //title 용
        body: SingleChildScrollView(
          child: buildColumn(context),
        )
    );
    }

    Widget buildColumn(BuildContext context) {
    List<Widget> result = List<Widget>();
    for(int count = 0; count < 7; count++) {
      result.add( buildRow(count) );
    }

    result.add( MaterialButton(
      onPressed: () async {
      Iterator stateIter = stateFormList.iterator;
      List<int> inputList = List();
      int input;
      int storedData;
      StateStudyTimeForm cursor;
      while(stateIter.moveNext() != false) {
          cursor = stateIter.current;
          input = int.parse(cursor.formController.text);
          inputList.add(input);
          storedData = StudyManagerState.targetCert.getPersonalTimeWithDate(
              cursor.targetDate);
          if (storedData != input) {
            if(storedData != 0) {
              StudyManagerState.targetCert.modifyPersonalTimeWithDate(
                  cursor.targetDate, input - storedData);
            }
            else {
              StudyManagerState.targetCert.personalTime.add(new StudyTime(cursor.targetDate, cursor.targetDate.add(new Duration(hours: input))));
            }
          }
      }
      await Firestore.instance.collection('ObjectList')
          .where('certName', isEqualTo: StudyManagerState.targetCert.CertName)
          .where('user', isEqualTo: CalenderPage.emailID).getDocuments()
          .then((QuerySnapshot qs) {
         qs.documents.forEach((element) {
           if(element.data['${weekday[0]}'] == null) {
             Firestore.instance.collection('ObjectList').document('${element.documentID}').setData({
               '${weekday[0]}': '${inputList[0]}',
               '${weekday[1]}': '${inputList[1]}',
               '${weekday[2]}': '${inputList[2]}',
               '${weekday[3]}': '${inputList[3]}',
               '${weekday[4]}': '${inputList[4]}',
               '${weekday[5]}': '${inputList[5]}',
               '${weekday[6]}': '${inputList[6]}',
               'standardDay': '${DateTool.getWeekMonday(DateTime.now())}',
             }, merge: true );
           } else {
             Firestore.instance.collection('ObjectList').document('${element.documentID}').updateData({
               '${weekday[0]}': '${inputList[0]}',
               '${weekday[1]}': '${inputList[1]}',
               '${weekday[2]}': '${inputList[2]}',
               '${weekday[3]}': '${inputList[3]}',
               '${weekday[4]}': '${inputList[4]}',
               '${weekday[5]}': '${inputList[5]}',
               '${weekday[6]}': '${inputList[6]}',
               'standardDay': '${DateTool.getWeekMonday(DateTime.now())}',
             });
           }
         });
      });
      stateFormList = new List<StateStudyTimeForm>();
      Navigator.pop(context);
//        StudyManagerState.updateStat();
      },
      child: Text("확인"),
    ));

    return Column(
    children: result
    );
  }

  Widget buildRow(int count) {
    DateTime today = DateTime.now();
    DateTime first = DateTool.getWeekMonday(today);
    List<String> weekday = ['월', '화', '수', '목', '금', '토', '일'];

    return Row(
      children: <Widget>[
        Text(weekday.elementAt(count) + '요일'),
        Expanded(
            child: StudyTimeForm(first.add(new Duration(days: count)))
        )
      ]
    );
  }
}


class StudyTimeForm extends StatefulWidget {

  DateTime targetDate;
  StudyTimeForm(this.targetDate);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    StateStudyTimeForm created = new StateStudyTimeForm(targetDate);
    RouteGetStudyTime.stateFormList.add(created);
    return created;
  }
}

class StateStudyTimeForm extends State<StudyTimeForm> {
  var formController;
  DateTime targetDate;
  StateStudyTimeForm(this.targetDate) {
    formController = TextEditingController(text: StudyManagerState.targetCert.getPersonalTimeWithDate(targetDate).toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    TextFormField formField = TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return "학습 시간을 입력해 주세요";
          }
          return null;
        },
      controller: formController
    );
    Form result = Form(
        child: formField
        );
    return result;
  }

}