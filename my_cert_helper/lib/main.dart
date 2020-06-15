import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mycerthelper/add_new_board_contexts.dart';
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
import 'package:mycerthelper/recommendation_result.dart';
import 'all_recommendation_question.dart';
import 'bottom_navigation_bar.dart';
import 'calendar_page.dart';
import 'each_recommendation_test_question.dart';
import 'each_test_setting.dart';
import 'infomation_market_page.dart';
import 'information_notification.dart';
import 'inner_board.dart';
import 'things_to_bring.dart';
import 'things_to_know.dart';
import 'certi_date.dart';
import 'certi_review.dart';
import 'work_review.dart';

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
const String ALL_RECOMMENDATION_QUESTION = '/study recommendation/all for question';
const String RECOMMENDATION_RESULT = '/study recommendation/recommendation result';
const String BOARD_CONTENTS = '/notice/infomation market/board contents';
const String ADD_NEW_BOARD_CONTEXTS = '/notice/infotmaiton market/add new board contexts';


final dummyItems = [
  'https://firebasestorage.googleapis.com/v0/b/certhelper-3e7f3.appspot.com/o/image%2Ftest_image1.PNG?alt=media&token=2e61859f-763d-4beb-9364-7859b68c84ac',
  'https://firebasestorage.googleapis.com/v0/b/certhelper-3e7f3.appspot.com/o/image%2Ftest_image2.PNG?alt=media&token=b562655c-7163-4186-a730-8384e67b291d',
  'https://firebasestorage.googleapis.com/v0/b/certhelper-3e7f3.appspot.com/o/image%2Ftest_image3.PNG?alt=media&token=712aceae-c962-40b1-8f33-f76e6fc728b1'
];


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
        RECOMMENDATION_TEST_PAGE : (context) => TestQuestion(TestScorePrediction.selected),
        LOGIN_PAGE : (context) => Splash(),
        ALL_RECOMMENDATION_QUESTION : (context) => AllRecommendationQuestion(TestQuestionState.nowHowMany),
        RECOMMENDATION_RESULT : (context) => RecommendationResult(TestQuestionState.score, AllRecommendationQuestionState.answerSet),
        INFORMATION_MARKET : (context) => marketBoard(),
        BOARD_CONTENTS : (context) => BoardContents(),
        ADD_NEW_BOARD_CONTEXTS : (context) => addNewBoardContext(),
      },
    );

    return mApp;
  }
}

class Splash extends StatelessWidget{
  static bool isFirstCall = true;
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
          if(isFirstCall == true) {
            isFirstCall = false;
            return UnderBar();
          }
          else
            return CalenderPage();
        }}
    );
  }
}