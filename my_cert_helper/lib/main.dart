import 'package:flutter/material.dart';
import 'package:mycerthelper/each_recommendation_test_question.dart';
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
const String INFORMATION_NOTIFICATION = '/notice';
const String INFORMATION_UTILITY = '/notice';
const String INFORMATION_CLASSIFICATION = '/notice';
const String INFORMATION_MARKET = '/notice';
const String PUSH_NOTIFICATION_PAGE = '/push notification page';
const String TO_DO_LIST_PAGE = '/to do list';
const String RECOMMENDATION_TEST_PAGE = '/study recommendation';

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
        PUSH_NOTIFICATION_PAGE : (context) => InfoNotification(),
        TO_DO_LIST_PAGE : (context) => ToDoListPage(),
        RECOMMENDATION_TEST_PAGE : (context) => TestQuestion(),
      },
    );
    return mApp;
  }
}