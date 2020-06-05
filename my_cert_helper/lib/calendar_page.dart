// json 직렬화
import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:firebase_helpers/firebase_helpers.dart';

// 캘린더 플러그인
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

// shared_preferences(key-value) 플러그인 : DB 저장, 읽기
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'calendar_testinfo.dart';
import 'calendar_edit_event.dart';

final Map<DateTime, List> _holidays = {
  DateTime(2020, 4, 15): ['21대 국회의원 선거'],
  DateTime(2020, 4, 30): ['부처님 오신 날'],
  DateTime(2020, 5, 5): ['어린이날'],
  DateTime(2020, 6, 6): ['현충일'],
  DateTime(2020, 8, 15): ['광복절'],
  DateTime(2020, 9, 30): ['추석'],
  DateTime(2020, 10, 1): ['추석'],
  DateTime(2020, 10, 2): ['추석'],
  DateTime(2020, 10, 3): ['개천절'],
  DateTime(2020, 10, 9): ['한글날'],
  DateTime(2020, 12, 25): ['성탄절'],
};

// dummyttoeic 미사용
final dummyttoeic = [
    {
    "testname": "토익 404회",
    "testday" : "2020-05-16 14:20",
    "lastsubday" : "2020-05-04 08:00",
    "passday" : "2020-05-28 06:00",
    "link" : "https://appexam.ybmnet.co.kr/toeic/receipt/receipt.asp"
    },
  
    {
    "testname": "토익 405회",
    "testday" : "2020-05-31 09:20",
    "lastsubday" : "2020-05-18 08:00",
    "passday" : "2020-06-11 06:00",
    "link" : "https://appexam.ybmnet.co.kr/toeic/receipt/receipt.asp"
    }
];

Map<DateTime, List<dynamic>> cal_events;
CalendarController cal_controller;

class CalenderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '캘린더',
      theme: ThemeData(
        primarySwatch: Colors.yellow // 주 색상 변경
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // 여기서 DB 확인 후 캘린더 설정

  
  List<dynamic> cal_selectedEvents;
  TextEditingController cal_eventController;
  SharedPreferences prefs;
  Firestore firestore = Firestore.instance;
  Stream<QuerySnapshot> streamData;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cal_controller = CalendarController();
    cal_eventController = TextEditingController();
    cal_events = {};
    cal_selectedEvents = [];
    initPrefs();
    streamData = firestore.collection('testinfo').snapshots();
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(

    );
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('캘린더'),
      ), // AppBar
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              locale: 'ko_KO',
              events: cal_events,
              holidays: _holidays,
              //initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                todayColor: Colors.blue, // 오늘 날짜 동그라미 색상
                selectedColor: Colors.orange, // 기본 색상과 동일한 선택날짜 색상
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),

              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
                formatButtonShowsNext: false,
              ),
//              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, cal_events){
                setState(() {
                  cal_selectedEvents = cal_events;
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, cal_events) => 
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Text(date.day.toString(), style: TextStyle(color:Colors.white),)),
                todayDayBuilder: (context, date, cal_events) => 
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: Text(date.day.toString(), style: TextStyle(color:Colors.white),)),
              ),
              calendarController: cal_controller,
              ),
             ... cal_selectedEvents.map((tevents) => Card(

// or ListTile(title: Text(event),)
               child: new GestureDetector(
                 onTap: () {
                   showDialog(
                    context: context,
                    builder : (context) => AlertDialog(
                      content: Text("일정을 삭제하시겠습니까?"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('아니오',style: TextStyle(color: Colors.black)), 
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                        ),
                        FlatButton(
                          child: Text('예',style: TextStyle(color: Colors.black)), 
                          onPressed: () {
                            setState(() {
                              //print(tevents.runtimeType);
                              //print("events".runtimeType);
                              //print(prefs.get("events"));
                              //print(prefs.getString("events"));

                              // 리스트를 지워야 함
                              //prefs.remove(tevents);
                              //prefs.clear();
                              prefs.remove("events");
                              //Navigator.of(context).pop();
                              Navigator.pop(context);

                              //Navigator.push(context, MaterialPageRoute(builder: (context) => CalenderPage()));
                              }
                            );
                          }, 
                        )
                      ],
                    ),                    
                   );
                 },
                 child: Container(
                   width: MediaQuery.of(context).size.width,
                   height: 50,
                   child: Padding(
                     padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                     child: Text(tevents, style: TextStyle(fontSize: 18),)
                     )
                 ),
               ),
             )),
          ]
        )
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size:22.0),
        closeManually: true,
        tooltip: '일정을 추가합니다.',
        child: Icon(Icons.add),
        onOpen: () => print('Dial Opened'),
        onClose: () => print('Dial Closed'),
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: Icon(Icons.calendar_today),
            backgroundColor: Colors.white,
            foregroundColor: Colors.orange,
            label: '일정 추가',
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            onTap: () {
              addSchedule();
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.library_books),
            backgroundColor: Colors.white,
            foregroundColor: Colors.blue,
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
            label: '시험 일정 추가',
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute<void>(builder: (BuildContext context) {
                return editTestDay();
              })
             );
            },
          ),          
        ],
      ),     
    );
  }

// 일정 추가
    addSchedule() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: cal_eventController,
        ), //TextField
        actions: <Widget>[
          FlatButton(
            child: Text('저장', style: TextStyle(color: Colors.black),),
            onPressed: () {
              if(cal_eventController.text.isEmpty) return;
              setState(() {
                 if(cal_events[cal_controller.selectedDay]!= null) {
                 cal_events[cal_controller.selectedDay].add(cal_eventController.text);
                }
                else {
                  cal_events[cal_controller.selectedDay] = [cal_eventController.text];
               }
               prefs.setString("events", json.encode(encodeMap(cal_events)));
               cal_eventController.clear();
               Navigator.pop(context);
              });
            },
          ),
        ],
      )
    );
  }
}

