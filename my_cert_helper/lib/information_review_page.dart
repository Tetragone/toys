import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycerthelper/page_test_setting.dart';
import 'package:mycerthelper/things_to_bring.dart';
import 'package:mycerthelper/things_to_know.dart';
import 'package:mycerthelper/work_review.dart';

import 'certi_date.dart';
import 'certi_review.dart';
import 'data_group.dart';
import 'dialog_search_cert.dart';

class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() {
    // TODO: implement createState
    return ReviewPageState();
  }
}

class CertData {
  String name;
  String prepare;
  String prepareLink;
  String rule;
  String ruleLink;
  List<String> difficultyReview = List<String>();
  List<String> usabilityReview = List<String>();
  List<CertTestTime> testTimeList = List<CertTestTime>();

  double getMean(List<int> target) {
    int total = 0;
    Iterator<int> cursor = target.iterator;

    while(cursor.moveNext() == true) {
      total = total + cursor.current;
    }

    return (total / target.length);
  }
}

class CertTestTime {
  DateTime time;
  String link;
  CertTestTime(time, link) {
    this.time = time;
    this.link = link;
  }
}

class ReviewPageState extends State<ReviewPage> {

  static Firestore firestore = Firestore.instance;
  Stream<QuerySnapshot> currentStream;
  TextFormField searchBox;
  TextEditingController searchBoxControl;
  static String selectedName;
  int difficultCount = 0;
  int valueCount = 0;
  Data data;
  String orga;
  String classifi;
  static CertData certData;

  @override
  void initState() {
    super.initState();
    currentStream = firestore.collection("CertList").snapshots();
    searchBoxControl = new TextEditingController();
    searchBox = new TextFormField(
        controller: searchBoxControl,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: onSearchBoxClicked,
          ),
          hintText: '우측의 돋보기를 클릭하세요!',
        ));
  }

  static loadCertData() async {
    certData = CertData();
    certData.name = selectedName;
    CertObjective result = CertObjective();
    result.CertName = selectedName;
    var qSnap = await firestore.collection("/CertList").getDocuments();
    var docList = qSnap.documents;
    var docIter = docList.iterator;
    Iterator<DocumentSnapshot> docIterAggr;

    QuerySnapshot qSnapAggr;
    //docIterAggr

    while (docIter.moveNext() == true) {
      if (docIter.current.data['name'] == result.CertName) {
        certData.prepare = docIter.current.data['prepare'];
        certData.prepareLink = docIter.current.data['prepareLink'];
        certData.rule = docIter.current.data['rule'];
        certData.ruleLink = docIter.current.data['ruleLink'];

        qSnapAggr = await firestore.collection(
            "/CertList/" + docIter.current.documentID + "/Difficulty")
            .getDocuments();

        docIterAggr = qSnapAggr.documents.iterator;
        while (docIterAggr.moveNext() == true) {
          certData.difficultyReview.add(docIterAggr.current.data['score']);
        }

        qSnapAggr = await firestore.collection(
            "CertList/" + docIter.current.documentID + "/Usability")
            .getDocuments();

        docIterAggr = qSnapAggr.documents.iterator;
        while (docIterAggr.moveNext() == true) {
          certData.usabilityReview.add(docIterAggr.current.data['score']);
        }

        qSnapAggr = await firestore.collection(
            "CertList/" + docIter.current.documentID + "/Test")
            .getDocuments();

        docIterAggr = qSnapAggr.documents.iterator;
        while (docIterAggr.moveNext() == true) {
          certData.testTimeList.add(CertTestTime(
              DateTime.parse(docIterAggr.current.data['testTime']),
              docIterAggr.current.data['testLink']));
        }
      }
    }
  }

  onSearchBoxClicked() async {
    String input = searchBoxControl.text;
    Future<QuerySnapshot> qFuture;
    QuerySnapshot qSnap;
    DocumentSnapshot docSnap;
    List<DocumentSnapshot> docList;
    List<String> resultList = List();
    Iterator<DocumentSnapshot> docIter;
    List<Future> fuList = new List<Future>();
    List<Widget> optionList = List<Widget>();
    String strTmp;
    String strTmp_class;
    String strTmp_orga;
    Future<String> fuResult;

    qSnap = await firestore.collection("CertList").getDocuments();
    docList = qSnap.documents;
    docIter = docList.iterator;

    while (docIter.moveNext() == true) {
      strTmp = docIter.current.data["name"];
      strTmp_class = docIter.current.data["classification"];
      strTmp_orga = docIter.current.data["organizer"];

      if (strTmp.contains(input) == true) {
        resultList.add(strTmp);
        optionList.add(
            UIChooseCertOption2(strTmp, this, strTmp_orga, strTmp_class));
      }
    }

    selectedName = await showDialog<String>(context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Text("자격증을 선택해 주십시오"),
              children: optionList
          );
        }
    );
    if (selectedName != null) {
      loadCertData();
      /*
      certData = CertData();
      certData.name = selectedName;
      CertObjective result = CertObjective();
      result.CertName = selectedName;
      qSnap = await firestore.collection("/CertList").getDocuments();
      docList = qSnap.documents;
      docIter = docList.iterator;
      Iterator<DocumentSnapshot> docIterAggr;

      QuerySnapshot qSnapAggr;
      //docIterAggr

      while (docIter.moveNext() == true) {
        if (docIter.current.data['name'] == result.CertName) {
          certData.prepare = docIter.current.data['prepare'];
          certData.prepareLink = docIter.current.data['prepareLink'];
          certData.rule = docIter.current.data['rule'];
          certData.ruleLink = docIter.current.data['ruleLink'];

          qSnapAggr = await firestore.collection(
              "/CertList/" + docIter.current.documentID + "/Difficulty")
              .getDocuments();

          docIterAggr = qSnapAggr.documents.iterator;
          while(docIterAggr.moveNext() == true) {
            certData.difficulty.add(int.parse(docIterAggr.current.data['score']));
          }

          qSnapAggr = await firestore.collection(
              "CertList/" + docIter.current.documentID + "/Usability")
              .getDocuments();

          docIterAggr = qSnapAggr.documents.iterator;
          while(docIterAggr.moveNext() == true) {
            certData.usability.add(int.parse(docIterAggr.current.data['score']));
          }

          qSnapAggr = await firestore.collection(
              "CertList/" + docIter.current.documentID + "/Test")
              .getDocuments();

          docIterAggr = qSnapAggr.documents.iterator;
          while(docIterAggr.moveNext() == true) {
            certData.testTimeList.add(CertTestTime(DateTime.parse(docIterAggr.current.data['testTime']), docIterAggr.current.data['testLink']));
          }
        }
      }
    } */

      setState(() {});
    }
  }

    Widget _buildPadding1() {
      return Container(
        padding: EdgeInsets.all(5),
      );
    }

    /* Widget _buildTop(BuildContext context){
    return CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          height: 150,
        ),
        items: dummyItems.map((url) {
          return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
          );
        }).toList()
    );
  }

  Widget _buildPadding2(){
    return Container(
      padding: EdgeInsets.all(5),
    );
  }

*/

    Widget _buildBottom(BuildContext context) {
      final items = List.generate(1, (i) {
        return Column(
            children: <Widget>[
              Card(
                child: ListTile(
                  leading: Icon(Icons.calendar_today, color: Colors.cyan[200],
                      size: 52.0),
                  title: Text('시험일'),
                  subtitle: Text('시험일, 시험일 입실시간'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return CertiDate(); // 바로가기할 페이지
                            }));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                      Icons.assignment_turned_in, color: Colors.cyan[200],
                      size: 52.0),
                  title: Text('시험 준비물'),
                  subtitle: Text('시험 필수 준비'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return ThingsToBring(); // 바로가기할 페이지
                            }));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.assignment_late, color: Colors.cyan[200],
                      size: 52.0),
                  title: Text('시험 주의사항'),
                  subtitle: Text('주의사항 및 시험장 내 팁'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return ThingsToKnow(); // 바로가기할 페이지
                            }));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                      Icons.star, color: Colors.cyan[200], size: 52.0),
                  title: Text('난이도 평가'),
                  subtitle: Text('다른 사용자의 난이도 평가를 확인합니다'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return CertiReview(); // 바로가기할 페이지
                            }));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                      Icons.star, color: Colors.cyan[200], size: 52.0),
                  title: Text('실무활용 평가'),
                  subtitle: Text('다른 사용자의 실무 활용도를 확인합니다.'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                              return WorkReview(); // 바로가기할 페이지
                            }));
                  },
                ),
              ),
            ]
        );
      });

      return ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: items,
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('자격증 평가'),
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            searchBox,
            SizedBox(
              height: 10.0,
            ),
            Center(
                child: Text(
                    selectedName == null ? '자격증을 선택해 주세요' : selectedName, style: TextStyle(fontSize: 20), )
            ),
            _buildPadding1(),
            _buildBottom(context),
          ],
        ),
      );
    }
  }
