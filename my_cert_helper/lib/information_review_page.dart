
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycerthelper/page_test_setting.dart';

import 'data_group.dart';
import 'dialog_search_cert.dart';
/*
class ReviewPage extends StatefulWidget {
  @override
  State<ReviewPage> createState() {
    // TODO: implement createState
    return ReviewPageState();
  }
}

class ReviewPageState extends State<ReviewPage> {

  Firestore firestore = Firestore.instance;
  Stream<QuerySnapshot> currentStream;
  TextFormField searchBox;
  TextEditingController searchBoxControl;
  String selectedName;
  int difficultCount = 0;
  int valueCount = 0;
  Data data;

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
          hintText: '자격증을 입력해주세요!',
        ));
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

    while(docIter.moveNext() == true) {
      strTmp= docIter.current.data["name"];
      strTmp_class = docIter.current.data["classification"];
      strTmp_orga = docIter.current.data["organizer"];

      if(strTmp.contains(input) == true) {
        resultList.add(strTmp);
        optionList.add(UIChooseCertOption2(strTmp, this, strTmp_orga, strTmp_class));
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

    if(selectedName != null ) {
      CertObjective result = CertObjective();
      result.CertName = selectedName;
      qSnap = await firestore.collection("CertList").getDocuments();
      docList = qSnap.documents;
      docIter = docList.iterator;
      QuerySnapshot qSnapAggr;
      docIterAggr

      while(docIter.moveNext() != true) {
        if( docIter.current.data['name'] == result.CertName ) {
          qSnapAggr = await firestore.collection("CertList/" + docIter.current.documentID + "/Review" ).getDocuments();

        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('자격증 평가'),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              searchBox,
              StreamBuilder<QuerySnapshot> (
                stream: Firestore.instance.collection('CertList').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return LinearProgressIndicator();

                  return ;
                },
              ),
            ]

        ));
  }
}

    // TODO: implement build
    return
  }

}

class TestSettingPageState extends State<TestSettingPage> {




  @override
  Widget build(BuildContext context) {

class SelectedBox extends StatefulWidget{
  List<CertObjective> objList;
  StateSelectedBox created;

  @override
  State<StatefulWidget> createState() {
    created = new StateSelectedBox();
    created.objList = objList;
    // TODO: implement createState
    return created;
  }

  SelectedBox(List<CertObjective> objList) {
    this.objList = objList;
  }
}

class StateSelectedBox extends State<SelectedBox> {
  List<CertObjective> objList;
  List<Widget> buttonList;
  Iterator<CertObjective> iter;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    buttonList = new List<Widget>();
    iter = objList.iterator;
    while(iter.moveNext() == true) {
      buttonList.add(
          Card(child: myListTile(iter.current, context),)
      );
    }

    return Column(children: buttonList);
  }
}

class ButtonBox extends RaisedButton {
  final CertObjective cert;

  ButtonBox(CertObjective arg, BuildContext context): cert=arg,
        super(//뒤에 배경 이미지를 넣을려면 container로 바꿔서 구현해야한다.
          child: Text('${arg.CertName}'),
          color: Colors.limeAccent,
          onPressed: () {
            Navigator.of(context).pushNamed(
              EACH_TEST_SETTING,
              arguments: <String, CertObjective>{
                'obj': arg
              },
            );
          });
}

class myListTile extends ListTile {
  final CertObjective cert;

  myListTile(CertObjective arg, BuildContext context)
      : cert = arg,
        super(
          title: Text('${arg.CertName}'),
          trailing:Text('${arg.classificationName}'),
          subtitle: Text('${arg.organizerName}'),
//        leading: Icon(Icons.title), 여기는 각자 logo를 넣으면 어떨까요?
          onTap: () {
            Navigator.of(context).pushNamed(
              EACH_TEST_SETTING,
              arguments: <String, CertObjective>{
                'obj': arg
              },
            );
          }
      );
}
*/
