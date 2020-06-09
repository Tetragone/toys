import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mycerthelper/data/join_or_login.dart';
import 'package:mycerthelper/page_input_study_time.dart';
import 'package:mycerthelper/page_study_manage.dart';
import 'package:mycerthelper/page_test_setting.dart';
import 'package:mycerthelper/page_to_do_list.dart';
import 'package:mycerthelper/screens/login.dart';
import 'package:mycerthelper/screens/main_page.dart';
import 'package:mycerthelper/study_time_check_and_compare.dart';
import 'package:mycerthelper/test_score_prediction.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation_bar.dart';
import 'each_recommendation_test_question.dart';
import 'each_test_setting.dart';
import 'information_notification.dart';

const String ROOT_PAGE = '/';
const String TEST_SETTING_PAGE = '/test setting';
const String STUDY_TIME_CHECK_PAGE = '/time check';
const String TEST_SCORE_PREDICTION_PAGE = '/score perdiction';
const String TIME_SETTING_PAGE = '/time setting';
const String TEST_SCORE_PREDICTION = '/score perdiction/each test';
const String EACH_TEST_SETTING = '/test setting/each test setting';
const String INFORMATION_NOTIFICATION = '/notice';
const String INFORMATION_UTILITY = '/notice';
const String INFORMATION_CLASSIFICATION = '/notice';
const String INFORMATION_MARKET = '/notice';
const String PUSH_NOTIFICATION_PAGE = '/push notification page';
const String TO_DO_LIST_PAGE = '/to do list';
const String RECOMMENDATION_TEST_PAGE = '/study recommendation';
const String LOGIN_PAGE = '/login';


void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatefulWidget{
  @override
  State createState() => MyAppState();
}


class MyAppState extends State<MyApp> {

  static MaterialApp mApp;
  @override
  Widget build(BuildContext context) {
    mApp = MaterialApp(
      title: 'Write the name',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,

      initialRoute: LOGIN_PAGE,
      routes: {
        ROOT_PAGE : (context) => UnderBar(),
        TEST_SETTING_PAGE : (context) => TestSettingPage(StudyManagerState.data),
        STUDY_TIME_CHECK_PAGE : (context) => StudyTimeCheckAndCompare(StudyManager.state),
        TEST_SCORE_PREDICTION_PAGE : (context) => TestScorePrediction(),
        TIME_SETTING_PAGE : (context) => RouteGetStudyTime(),
        EACH_TEST_SETTING : (context) => EachTestSetting(),
        PUSH_NOTIFICATION_PAGE : (context) => InfoNotification(),
        TO_DO_LIST_PAGE : (context) => ToDoListPage(),
        RECOMMENDATION_TEST_PAGE : (context) => TestQuestion(),
        LOGIN_PAGE : (context) => Splash(),
      },
    );

    return mApp;
  }
}

class Splash extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {

        if(snapshot.data == null){ //파이어베이스에 데이터가 없으면 로그인이 안된 상태라는 것
        return ChangeNotifierProvider<JoinOrLogin>.value(
            value: JoinOrLogin(),   // ;인지 ,인지 ????????
            child: AuthPage());
      }else{
          return UnderBar();
        }}
    );
  }
}