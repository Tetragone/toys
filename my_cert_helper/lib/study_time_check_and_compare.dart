import 'package:flutter/material.dart';
import 'package:mycerthelper/data_group.dart';
import 'package:mycerthelper/main.dart';
import 'package:mycerthelper/page_study_manage.dart';

import 'bottom_navigation_bar.dart';

class StudyTimeCheckAndCompare extends StatefulWidget {
  StudyManagerState manager;

  StudyTimeCheckAndCompare(StudyManagerState manager);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateStudyTimeCheckAndCompare(manager);
  }
}

class StateStudyTimeCheckAndCompare extends State<StudyTimeCheckAndCompare> {
  StudyManagerState manager;

  StateStudyTimeCheckAndCompare(StudyManagerState manager);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text('대시보드 설정'),),
        body: Column(
            children: <Widget>[
              Expanded(
                  flex: 10,
                  child: ListView.builder(
                      itemCount: Data.certObj.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(Data.certObj.elementAt(index)
                            .CertName),
                        trailing: Radio<CertObjective>(value: Data.certObj.elementAt(index), groupValue: StudyManagerState.targetCert,
                        onChanged: (CertObjective selected) {
                        StudyManagerState.targetCert = selected;
                        this.setState((){});
                        StudyManager.state.updateStat();
                        StudyTimeBox.state.updateStat();
                        }
    ));
                      }))]));
}}