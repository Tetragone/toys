// json 직렬화
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_helpers/firebase_helpers.dart';

// 캘린더 플러그인
import 'package:table_calendar/table_calendar.dart';

// shared_preferences(key-value) 플러그인 : DB 저장, 읽기
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'calendar_testinfo.dart';
import 'calendar_model_event.dart';
import 'calendar_add_event.dart';
import 'calendar_firestore.dart';
import 'data_group.dart';
import 'calendar_view_event.dart';

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


class CalenderPage extends StatefulWidget {
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  Map<DateTime, List<dynamic>> cal_events;
  CalendarController cal_controller;

  // 여기서 DB 확인 후 캘린더 설정
  List<dynamic> cal_selectedEvents;
  TextEditingController cal_eventController;
  SharedPreferences prefs;
  Firestore firestore = Firestore.instance;
  Stream<QuerySnapshot> streamData;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    cal_controller = CalendarController();
    cal_eventController = TextEditingController();
    cal_events = {};
    cal_selectedEvents = [];
  }

  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uemail = user.email;
    print(uemail);
    // here you write the codes to input the data into firestore
  }
  
  Map<DateTime, List<dynamic>> groupEvents(List<EventModel> events) {
    Map<DateTime,List<dynamic>> data = {};
    events.forEach((event) {
      DateTime date = DateTime(event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if(data[date] == null) {
        data[date] = [];
      }
      data[date].add(event);
    });
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('캘린더'),
      ), // AppBar
      body: StreamBuilder<List<EventModel>>(
        stream: eventDBS.streamList(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            List<EventModel> allEvents = snapshot.data;
            if(allEvents.isNotEmpty) {
              cal_events = groupEvents(allEvents);
            }
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TableCalendar(
                  locale: 'ko_KO',
                  events: cal_events,//cal_events,
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
                  onDaySelected: (date, events){
                    setState(() {
                      cal_selectedEvents = events;
                    });
                  },
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => 
                    Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Text(date.day.toString(), style: TextStyle(color:Colors.white),)),
                    todayDayBuilder: (context, date, events) => 
                    Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      child: Text(date.day.toString(), 
                      style: TextStyle(color:Colors.white),
                      )),
                  ),
                  calendarController: cal_controller,
                  ),
                 ... cal_selectedEvents.map((event) => Card(
                   child: Container(
                     child: ListTile(
                       title: Text(event.title),
                         onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetails(event: event,)));
                            setState(() {
                              
                            });
                         },
                     ),
                   ),
                 )
                ),
              ]
            )
          );
        }
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent()));
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
                editTestDay.selected = false;
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
               //prefs.setString("events", json.encode(encodeMap(cal_events)));
               cal_eventController.clear();
               Navigator.pop(context);
              });
            },
          ),
        ],
      )
    );
  }
  @override
  void dispose() {
    cal_eventController.dispose();
    super.dispose();
  }
}
/*
                           
                           showDialog(
                            context: context,
                            builder : (context) => AlertDialog(
                              content: Text("일정 자세히 보기"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('예',style: TextStyle(color: Colors.black)), 
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetails(event: event,)));
                                  }, 
                                ),
                                FlatButton(
                                  child: Text('아니오',style: TextStyle(color: Colors.black)), 
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }, 
                                ),
                              ],
                            ),                    
                           );
                                                  */

                 /*
Card(
// or ListTile(title: Text(event),)
                   child: new GestureDetector(
                     onTap: () {
                       showDialog(
                        context: context,
                        builder : (context) => AlertDialog(
                          content: Text("일정 상세/ 일정 삭제"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('일정 상세',style: TextStyle(color: Colors.black)), 
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetails(event: event,)));
                              }, 
                            ),
                            FlatButton(
                              child: Text('일정 지우기',style: TextStyle(color: Colors.black)), 
                              onPressed: () {
                                setState(() {
                                  print(event);
                                  Firestore.instance
                                    .collection('events')
                                    .document('temp')
                                    .delete();                                    
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
                         child: Text(event.title, style: TextStyle(fontSize: 18),)
                         )
                     ),
                   ),
                 )
                 */