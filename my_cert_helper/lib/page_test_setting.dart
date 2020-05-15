
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mycerthelper/dialog_search_cert.dart';

import 'data_group.dart';
import 'main.dart';

class TestSettingPage extends StatefulWidget {
  Data data;

  TestSettingPage(Data data) {
    this.data = data;
  }

  @override
  State createState() => TestSettingPageState(data);
}

class TestSettingPageState extends State<TestSettingPage> {
  Firestore firestore = Firestore.instance;
  Stream<QuerySnapshot> currentStream;
  TextFormField searchBox;
  TextEditingController searchBoxControl;
  String selectedName;
  Data data;
  SelectedBox box;

  TestSettingPageState(Data data) {
    this.data = data;
  }


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
    box = SelectedBox(data.certObj);
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
    Future<String> fuResult;

    qSnap = await firestore.collection("CertList").getDocuments();
    docList = qSnap.documents;
    docIter = docList.iterator;

    while(docIter.moveNext() == true) {
      strTmp= docIter.current.data["name"];
      if(strTmp.contains(input) == true) {
        resultList.add(strTmp);
        optionList.add(UIChooseCertOption(strTmp, this));
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
    if(selectedName != null) {
      CertObjective result = CertObjective();
      result.CertName = selectedName;
      data.certObj.add(result);
      box.created.setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('응시 자격증 설정'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            searchBox,
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text('설정된 자격증'),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                box
                ]
            ),
          ]

        ));
  }
}

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
  Column col;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    buttonList = new List<Widget>();
    iter = objList.iterator;
    while(iter.moveNext() == true) {
      buttonList.add(
          ButtonBox(iter.current, context)
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