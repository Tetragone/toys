import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycerthelper/page_study_manage.dart';

import 'data_group.dart';

// 코드를 좀더 가독성 있게 바꿀 예정이에요!
class RouteGetStudyTime extends StatelessWidget{
  static List<StateStudyTimeForm> stateFormList = new List<StateStudyTimeForm>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('공부시간 입력')), //title 용
        body: buildColumn(context)
    );
    }

    Widget buildColumn(BuildContext context) {
    List<Widget> result = List<Widget>();
    for(int count = 0; count < 7; count++) {
      result.add( buildRow(count) );
    }

    result.add( MaterialButton(
      onPressed: ()
      {
      Iterator stateIter = stateFormList.iterator;
      int input;
      int storedData;
      StateStudyTimeForm cursor;
      while(stateIter.moveNext() != false) {
          cursor = stateIter.current;
          input = int.parse(cursor.formController.text);
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
  bool needRedraw = false;

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