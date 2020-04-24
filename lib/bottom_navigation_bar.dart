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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(title: Text(''),),
      body: selectUnderBar[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: _ontap,
        currentIndex: _currentIndex,
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
}