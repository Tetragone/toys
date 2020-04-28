// json 직렬화
import 'dart:convert';

// http
import 'package:http/http.dart';

import 'package:flutter/material.dart';

// 캘린더 플러그인
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

// shared_preferences(key-value) 플러그인 : DB 저장, 읽기
import 'package:shared_preferences/shared_preferences.dart';

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
        onPressed: _editTestDay,
        ),
    );
  }
    _editTestDay() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _eventController,
        ), //TextField
        actions: <Widget>[
          FlatButton(
            child: Text('저장'),
            color: Colors.green,
            onPressed: () {
              if(_eventController.text.isEmpty) return;
              setState(() {
                 if(_events[_controller.selectedDay]!= null) {
                 _events[_controller.selectedDay].add(_eventController.text);
                }
                else {
                  _events[_controller.selectedDay] = [_eventController.text];
               }
               prefs.setString("events", json.encode(encodeMap(_events)));
               _eventController.clear();
               Navigator.pop(context);
              });
            },
          )
        ],
      )
    );
  }
}