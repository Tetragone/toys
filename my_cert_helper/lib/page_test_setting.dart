import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycerthelper/dialog_search_cert.dart';
import 'package:mycerthelper/page_study_manage.dart';

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
  String selectedClass;
  String selectedOrga;
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
    box = SelectedBox(Data.certObj);
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
        optionList.add(UIChooseCertOption(strTmp, this, strTmp_orga, strTmp_class));
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
    if(selectedName != null && selectedClass != null && selectedOrga != null) {
      CertObjective result = CertObjective();
      result.CertName = selectedName;
      result.classificationName = selectedClass;
      result.organizerName = selectedOrga;
      Data.certObj.add(result);
      box.created.setState(() {});
    }
  }

  @override
  Widget build(BuildContext context)  {
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
            ),/*
            IconButton(
                icon: Icon(Icons.save),
                tooltip: "자격증 정보 동기화",
                onPressed:() async {
                  if(Data.certObj != null) {
                    Firestore store = Firestore.instance;
                    DocumentSnapshot result;
                    QuerySnapshot qResult;
                    Iterator<CertObjective> objectCursor;
                    FirebaseUser user = await FirebaseAuth.instance.currentUser();

                    objectCursor = Data.certObj.iterator;
                    while(objectCursor.moveNext() == true) {
                      qResult = await store.collection('/ObjectList').where('certName', isEqualTo: objectCursor.current.CertName)
                          .where('user', isEqualTo: user.email).getDocuments();
                      if(qResult.documents.isEmpty == false) {
                        result = qResult.documents.elementAt(0);
                        await store.collection('/ObjectList').document(result.documentID).setData({
                          'certName' : objectCursor.current.CertName ,
                          'color' : objectCursor.current.selected.value.toString(),
                          'isTested' : objectCursor.current.isTested == true ? "true" : "false" ,
                          'priority' : objectCursor.current.priority.toString() ,
                          'targetGrade' : objectCursor.current.targetGrade.toString() ,
                          'user' : user.email ,
                        'classification': objectCursor.current.classificationName,
                        'organizer': objectCursor.current.organizerName

                        });
                      }

                      else {
                        await firestore.collection('/ObjectList').document().setData({
                          'certName' : objectCursor.current.CertName ,
                          'color' : objectCursor.current.selected.value.toString(),
                          'isTested' : objectCursor.current.isTested == true ? "true" : "false" ,
                          'priority' : objectCursor.current.priority.toString() ,
                          'targetGrade' : objectCursor.current.targetGrade.toString() ,
                          'user' : user.email ,
                          'classification': objectCursor.current.classificationName,
                          'organizer': objectCursor.current.organizerName
                        });
                      }
                      Fluttertoast.showToast(
                          msg: "저장됨",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          fontSize: 16.0
                      );

                    }


                  }
                }),
                */
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

