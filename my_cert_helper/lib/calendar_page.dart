// json 직렬화
import 'dart:convert';

import 'package:flutter/material.dart';

// 캘린더 플러그인
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

// shared_preferences(key-value) 플러그인 : DB 저장, 읽기
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



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


class CalenderPage extends StatefulWidget{

  @override
  State createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage>{

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
    initializeDateFormatting('pt_BR', null);
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
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
              events: _events,
              holidays: _holidays,
              //initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                todayColor: Colors.orange, // 오늘 날짜 동그라미 색상
                selectedColor: Theme.of(context).primaryColor, // 기본 색상과 동일한 선택날짜 색상
                todayStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),

              ),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                ),
                formatButtonShowsNext: false,
              ),
//              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events){
                setState(() {
                  _selectedEvents = events;
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => 
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(date.day.toString(), style: TextStyle(color:Colors.white),)),
                todayDayBuilder: (context, date, events) => 
                Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(date.day.toString(), style: TextStyle(color:Colors.white),)),
              ),
              calendarController: _controller,
              ),
             ... _selectedEvents.map((event) => ListTile(
               title: Text(event),

             )),
          ]
        )
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: '자격증 시험 일정을 추가합니다.',
        label: Text('일정 추가'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(context,
          MaterialPageRoute<void>(builder: (BuildContext context) {
            return _editTestDay();
            })
          );
        }
      ),
    );
  }
}


class _editTestDay extends StatefulWidget {
  @override
  __editTestDayState createState() => __editTestDayState();
}

class __editTestDayState extends State<_editTestDay> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('자격증 시험 일정 추가')
        ),
        body: _showTest(context, dummyttoeic),
    );
  }

  Widget _showTest(BuildContext context, List<Map> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top:20.0),
      children: snapshot.map((data)=> _buildListItem(context,data)).toList()
    );
  }

  Widget _buildListItem(BuildContext context, Map data) {
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
         onTap: () => _showDialog(context,record.testname),
       ),
     ),
   );
  }

  void _showDialog(BuildContext context, text) {
  // 경고창을 보여주는 가장 흔한 방법.
    showDialog(
      context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('일정 추가'),
            content: Text('$text 시험을 캘린더에 추가합니까?.'),
            actions: <Widget>[
              FlatButton(
                child: Text('저장', style: TextStyle(color: Colors.black),),
                onPressed: () {
                  
                },
              )
            ],
            // 주석으로 막아놓은 actions 매개변수도 확인해 볼 것.
            // actions: <Widget>[
            //     FlatButton(child: Text('확인'), onPressed: () => Navigator.pop(context)),
            // ],
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