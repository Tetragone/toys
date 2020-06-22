// json 직렬화
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mycerthelper/each_test_setting.dart';

// 캘린더 플러그인
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

// shared_preferences(key-value) 플러그인 : DB 저장, 읽기
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'calendar_page.dart';
import 'calendar_model_event.dart';
import 'data_group.dart';
import 'calendar_firestore.dart';
import 'calendar_view_event.dart';


// 자격증 시험 일정 추가


class editTestDay extends StatefulWidget {
  static bool selected = false;
  final EventModel note;

  editTestDay({Key key, this.note}) : super(key: key);

  @override
  _editTestDayState createState() => _editTestDayState();
}

class _editTestDayState extends State<editTestDay> {
  static bool selected = editTestDay.selected;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  DateTime _eventDate;
  bool processing;
// 기존 코드
  SharedPreferences prefs;
  Stream<QuerySnapshot> stream;

    void initState() {
    // TODO: implement initState
    super.initState();
    _eventDate = DateTime.now();
    processing = false;

    if(selected == false){
      stream = Firestore.instance.collection('testinfo').snapshots();
    } else {
      stream = Firestore.instance.collection('testinfo').where('cert', isEqualTo: '${EachTestSettingState.obj.CertName}').snapshots();
    }
    //initPrefs();
  }

/*
  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      cal_events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자격증 시험 일정 추가'),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search),
          onPressed: () {
            
          },
          )
        ],
        
        ),
        body: buildBody(context),
    );
  }


  Widget buildBody(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return LinearProgressIndicator();
        }
        else {
          return showTest(context, snapshot.data.documents);
        }
      },
    );
  }

  Widget showTest(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top:20.0),
      children: snapshot.map((data)=> buildListItem(context,data)).toList()
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

   return Padding(
     key: ValueKey(record.testname),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text(record.testname),
         trailing: Text(record.testday.toString()),
         onTap: () => cal_showDialog(context,record.testname,record.testday, record),
       ),
     ),
   );
  }

  void cal_showDialog(BuildContext context, tname, tday, Record record) {

    var settname = tname;
    var settday = DateTime.parse(tday);
    showDialog(
      context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('일정 추가'),
            content: Text('$settname ($tday) 시험을 캘린더에 추가합니까?'),
            actions: <Widget>[
              FlatButton(
                child: Text('저장', style: TextStyle(color: Colors.black, fontSize: 17),),
                onPressed: ()  {
                  setState(() {
                    if(Data.getCertObjByName(record.testCert) != null) {
                      Data.getCertObjByName(record.testCert).examDate.add(DateTime.parse(tday));
                    }
                    eventDBS.createItem(EventModel(
                      title: tname,
                      description: tday,
                      eventDate: settday
                      ));
                      Navigator.pop(context);
                  });
                }
              )
            ],
        );
      }
    );
  }
}

class Record {
 final String testname;
 final String testday;
 final String testCert;

 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['testname'] != null),
       assert(map['testday'] != null),

       testname = map['testname'],
       testday = map['testday'],
       testCert = map['cert'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$testname:$testday>";
}


