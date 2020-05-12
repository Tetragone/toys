import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'page_test_setting.dart';
import 'study_time_check_and_compare.dart';
import 'test_score_%20prediction.dart';
import 'bottom_navigation_bar.dart';
import 'page_input_study_time.dart';
import 'each_test_setting.dart';

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

class MyApp extends StatefulWidget {
  @override
  State createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Write the name',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: ROOT_PAGE,
      routes: {
        ROOT_PAGE : (context) => UnderBar(),
        TEST_SETTING_PAGE : (context) => TestSettingPage(),
        STUDY_TIME_CHECK_PAGE : (context) => StudyTimeCheckAndCompare(),
        TEST_SCORE_PREDICTION_PAGE : (context) => TestScorePrediction(),
        TIME_SETTING_PAGE : (context) => RouteGetStudyTime(),
        EACH_TEST_SETTING : (context) => EachTestSetting(),
      },
    );
  }
}