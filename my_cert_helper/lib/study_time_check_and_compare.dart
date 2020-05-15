import 'package:flutter/material.dart';
import 'package:mycerthelper/data_group.dart';
import 'package:mycerthelper/main.dart';
import 'package:mycerthelper/page_study_manage.dart';

import 'bottom_navigation_bar.dart';

class StudyTimeCheckAndCompare extends StatefulWidget{
  StudyManagerState manager;
  StudyTimeCheckAndCompare(StudyManagerState manager);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateStudyTimeCheckAndCompare(manager);
  }
}

class StateStudyTimeCheckAndCompare extends State<StudyTimeCheckAndCompare>{
  StudyManagerState manager;
  StateStudyTimeCheckAndCompare(StudyManagerState manager);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('공부 시간 확인 및 비교'),),
    body: Column(
    children: <Widget>[
    Expanded(
    flex: 10,
    child: ListView.builder(
    itemCount: StudyManagerState.data.certObj.length,
    itemBuilder: (context, index){
    return ListTile(
    title: Text(StudyManagerState.data.certObj.elementAt(index).CertName),
    trailing: Radio<CertObjective>(value: StudyManagerState.data.certObj.elementAt(index), groupValue: StudyManagerState.targetCert,
    onChanged: (CertObjective selected) {StudyManagerState.targetCert = selected;
    this.setState((){});
    UnderBarState.manager = StudyManager();
    Navigator.pushReplacementNamed(context, ROOT_PAGE);}
    )
    );
    }
    )
    )
    ]
    )
    );


    }
}