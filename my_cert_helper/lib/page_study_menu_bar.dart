import 'package:flutter/material.dart';
import 'main.dart';

class StudySetting extends StatefulWidget{

  @override
  State createState() => StudySettingState();
}

class StudySettingState extends State<StudySetting>{

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              '학습 관리 설정',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),//메뉴를 열었을때 맨위에 보이는 메뉴창 이름
          ListTile(
            leading: Icon(Icons.contact_mail),
            onTap: () => Navigator.pushNamed(context, TEST_SETTING_PAGE), //누를시 응시 자격증 페이지로 이동 코드
            title: Text('응시 자격증 설정'),
          ),
          ListTile(
            leading: Icon(Icons.access_time),
            onTap: () => Navigator.pushNamed(context, STUDY_TIME_CHECK_PAGE),
            title: Text('대시보드 설정'),
          ),
          ListTile(
            leading: Icon(Icons.contacts),
            onTap:  () => Navigator.pushNamed(context, TEST_SCORE_PREDICTION_PAGE),
            title: Text('공부 방법 추천'),
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            onTap:  () => Navigator.pushNamed(context, TO_DO_LIST_PAGE),
            title: Text('ToDo 리스트'),
          ),
        ],
      ),
    );
  }
} // 앱바 오른쪽 위에 메뉴바안에 내용물을 넣기 위한 코드

