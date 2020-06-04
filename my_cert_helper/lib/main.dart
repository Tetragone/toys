import 'package:flutter/material.dart';
import 'package:mycerthelper/page_study_manage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mycerthelper/page_to_do_list.dart';

import 'page_test_setting.dart';
import 'study_time_check_and_compare.dart';
import 'test_score_prediction.dart';
import 'bottom_navigation_bar.dart';
import 'page_input_study_time.dart';
import 'each_test_setting.dart';
import 'infromation_notification.dart';




void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

const String ROOT_PAGE = '/';
const String TEST_SETTING_PAGE = '/test setting';
const String STUDY_TIME_CHECK_PAGE = '/time check';
const String TEST_SCORE_PREDICTION_PAGE = '/score perdiction';
const String TIME_SETTING_PAGE = '/time setting';
const String TEST_SCORE_PREDICTION = '/score perdiction/each test';
const String EACH_TEST_SETTING = '/test setting/each test setting';
<<<<<<< HEAD
const String PUSH_NOTIFICATION_PAGE = '/infromation notification';
const String INFORMATION_NOTIFICATION = '/notice';
const String INFORMATION_UTILITY = '/notice';
const String INFORMATION_CLASSIFICATION = '/notice';
const String INFORMATION_MARKET = '/notice';

=======
const String PUSH_NOTIFICATION_PAGE = '/push notification page';
const String TO_DO_LIST_PAGE = '/to do list';
>>>>>>> origin/학습-관리-기능-구현

class MyApp extends StatefulWidget {
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
      initialRoute: ROOT_PAGE,
      routes: {
        ROOT_PAGE : (context) => UnderBar(),
        TEST_SETTING_PAGE : (context) => TestSettingPage(StudyManagerState.data),
        STUDY_TIME_CHECK_PAGE : (context) => StudyTimeCheckAndCompare(StudyManager.state),
        TEST_SCORE_PREDICTION_PAGE : (context) => TestScorePrediction(),
        TIME_SETTING_PAGE : (context) => RouteGetStudyTime(),
        EACH_TEST_SETTING : (context) => EachTestSetting(),
<<<<<<< HEAD
        // 임시
        INFORMATION_NOTIFICATION : (context) => InfoNotification(),
=======
        PUSH_NOTIFICATION_PAGE : (context) => PushNotificationService(),
        TO_DO_LIST_PAGE : (context) => ToDoListPage(),
>>>>>>> origin/학습-관리-기능-구현
      },
    );
    return mApp;
  }
}