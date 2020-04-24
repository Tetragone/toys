import 'package:flutter/material.dart';

import 'package:nowtimeidontdelete/calendar_page.dart';
import 'package:nowtimeidontdelete/information_setting_page.dart';
import 'package:nowtimeidontdelete/main_page.dart';
import 'page_study_manage.dart';

class UnderBar extends StatefulWidget{

  @override
  State createState() => UnderBarState();
}

class UnderBarState extends State<UnderBar> {
  int _currentIndex = 0;
  final List<Widget> selectUnderBar = [MainPage(), StudyManager(), CalenderPage(), InformationSettingPage()];

  void _ontap(int index) {
    setState(() {
      _currentIndex = index;
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
            icon: Icon(Icons.home),
            title: Text('메인'),
          ),
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
            title: Text('정보설정'),
          )
        ],
      ),
    );
  }
} // 밑에 바를 조절 할수 있는 코드