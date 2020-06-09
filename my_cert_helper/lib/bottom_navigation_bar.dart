import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'calendar_page.dart';
import 'information_setting_page.dart';
import 'main.dart';
import 'page_study_manage.dart';
import 'data_group.dart';


import 'dart:io';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UnderBar extends StatefulWidget{
  @override
  State createState() => UnderBarState();
}

class UnderBarState extends State<UnderBar> {
  Data data;
  int _currentIndex = 1;

  static StudyManager manager = StudyManager();
  final List<Widget> selectUnderBar = [manager, CalenderPage(), InformationSettingPage(), Splash()];

  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(), 
                child: Text('확인', style: TextStyle(color: Colors.black)),
              )
            ],
          )
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  void _ontap(int index) {
    setState(() {
      _currentIndex = index;
      if(index == 3)
        FirebaseAuth.instance.signOut();
    });
  } // 밑에 바를 누를 시에 실행하는 코드

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectUnderBar[_currentIndex], //밑에 바가 눌러졌을때 화면 전환을 위함
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, //밑에 바의 타입, 고정으로 만들었어요
        onTap: _ontap, //밑에 바 누를시 호출하는 함수
        currentIndex: _currentIndex, //현재 위치(초기값을 결정을 하면 처음에 나오는 위치 조절 가능)
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.border_color),
            title: Text('학습관리'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('캘린더'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('자격증 정보'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            title: Text('ID 변경'),
          )
        ],
      ),
    );
  }
} // 밑에 바를 조절 할수 있는 코드