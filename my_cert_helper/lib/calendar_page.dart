// json 직렬화
import 'dart:convert';

import 'package:flutter/material.dart';

// 캘린더 플러그인
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

// shared_preferences(key-value) 플러그인 : DB 저장, 읽기
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

  
  CalendarController cal_controller;
  List<dynamic> cal_selectedEvents;
  TextEditingController cal_eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cal_controller = CalendarController();
    cal_eventController = TextEditingController();
    cal_events = {};
    cal_selectedEvents = [];
    initPrefs();
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
                todayColor: Colors.green, // 오늘 날짜 동그라미 색상
                selectedColor: Colors.orange, // 기본 색상과 동일한 선택날짜 색상
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),

              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.green,
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
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(date.day.toString(), style: TextStyle(color:Colors.white),)),
                todayDayBuilder: (context, date, cal_events) => 
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(date.day.toString(), style: TextStyle(color:Colors.white),)),
              ),
              calendarController: cal_controller,
              ),
             ... cal_selectedEvents.map((tevents) => Card(

// or ListTile(title: Text(event),)
               child: Container(
                 width: MediaQuery.of(context).size.width,
                 height: 50,
                 child: Padding(
                   padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                   child: Text(tevents, style: TextStyle(fontSize: 18),)
                   )
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
        onOpen: () => print('일정 추가'),
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
              _addSchedule();
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.library_books),
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
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
    _addSchedule() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: cal_eventController,
        ), //TextField
        actions: <Widget>[
          FlatButton(
            child: Text('저장'),
            color: Colors.green,
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
          )
        ],
      )
    );
  }
}

// 자격증 시험 일정 추가

class editTestDay extends StatefulWidget {
  @override
  _editTestDayState createState() => _editTestDayState();
}

class _editTestDayState extends State<editTestDay> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자격증 시험 일정 추가')
        ),
        body: showTest(context, dummyttoeic),
    );
  }

  Widget showTest(BuildContext context, List<Map> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top:20.0),
      children: snapshot.map((data)=> buildListItem(context,data)).toList()
    );
  }

  Widget buildListItem(BuildContext context, Map data) {
    final record = Record.fromMap(data);

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
         onTap: () => cal_showDialog(context,record.testname,record.testday),
       ),
     ),
   );
  }

  void cal_showDialog(BuildContext context, tname, tday) {

    String settname = tname;
    DateTime settday = DateTime.parse(tday);
    DateTime _tday = tday;
    showDialog(
      context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('일정 추가'),
            content: Text('$settname ($tday) 시험을 캘린더에 추가합니까?'),
            actions: <Widget>[
              FlatButton(
                child: Text('저장', style: TextStyle(color: Colors.black, fontSize: 17),),
                onPressed: () {
                  //Navigator.pop(context);
                  // DB에 저장
//                  cal_events.addEntries(Map(tday));
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
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

 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['testname'] != null),
       assert(map['testday'] != null),

       testname = map['testname'],
       testday = map['testday'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$testname:$testday>";
}