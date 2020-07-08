import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:mycerthelper/data/join_or_login.dart';
import 'package:mycerthelper/screens/login.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation_bar.dart';
import 'calendar_page.dart';
import 'my_certi_portfolio.dart';


import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'dart:io';
import 'package:path/path.dart';

class MYCERTI extends StatefulWidget {
  @override
  _MYCERTIState createState() => _MYCERTIState();
}

class _MYCERTIState extends State<MYCERTI> {
  File _image;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String emailID;
  QuerySnapshot qSnap;
  List<DocumentSnapshot> docList;
  Iterator<DocumentSnapshot> docIter;
  String nickname;
  String birthdayString;
  DateTime birthdayDate;
  bool editable = false;
  String initNick;
  String initBirth;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  final formKey = GlobalKey<FormState>();
  String save = '저장';

  getUserInfo() async {
    return this._memoizer.runOnce(() async {
      await firebaseAuth.onAuthStateChanged
          .firstWhere((user) => user != null)
          .then((user) {
        emailID = user.email;
      });

      qSnap = await Firestore.instance.collection('myInfo').where('userEmail', isEqualTo: '$emailID').getDocuments();

      docList = qSnap.documents;
      docIter = docList.iterator;

      if(docIter.moveNext() == true) {
        nickname = docIter.current.data['Nickname'];
        birthdayString = docIter.current.data['Birthday'];
        initNick = nickname;
        initBirth = birthdayString;
        birthdayDate = DateTime.parse('$birthdayString');
      }else {
        nickname = '자뽀자기 (기본)';
        birthdayDate = DateTime.now();
      }
      return true;
    });

  }


  @override
  Widget build(BuildContext context) {

    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
          print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async{
      setState(() {
        save = '저장중';
      });

      formKey.currentState.save();
//      String fileName = basename(_image.path);
//      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
//      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
//      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;

      if (initNick == null && initBirth == null) {
        await Firestore.instance.collection('myInfo').add({
          'Nickname': '$nickname',
          'Birthday': '${birthdayDate.toString()}',
          'userEmail': '$emailID'
        });
      } else if (initNick == null) {
        await Firestore.instance.collection('myInfo')
            .where('userEmail', isEqualTo: '$emailID')
            .getDocuments().then((QuerySnapshot qs) {
              qs.documents.forEach((element) {
                Firestore.instance.collection('myInfo').document('${element.documentID}').updateData({
                  'Birthday': '${birthdayDate.toString()}'
                });
              });
        });

        await Firestore.instance.collection('myInfo').add({
          'Nickname': '$nickname',
        });
      } else if (initBirth == null) {
        await Firestore.instance.collection('myInfo').add({
          'Birthday': '${birthdayDate.toString()}',
        });

        await Firestore.instance.collection('myInfo')
            .where('userEmail', isEqualTo: '$emailID')
            .getDocuments().then((QuerySnapshot qs) {
          qs.documents.forEach((element) {
            Firestore.instance.collection('myInfo').document('${element.documentID}').updateData({
              'Nickname': '$nickname'
            });
          });
        });
      } else {
        await Firestore.instance.collection('myInfo')
            .where('userEmail', isEqualTo: '$emailID')
            .getDocuments().then((QuerySnapshot qs) {
          qs.documents.forEach((element) {
            Firestore.instance.collection('myInfo').document('${element.documentID}').updateData({
              'Birthday': '${birthdayDate.toString()}',
              'Nickname': '$nickname'
            });
          });
        });
      }

      setState(() {
         print("Profile Picture uploaded");
         save = '저장';
         Scaffold.of(context).showSnackBar(SnackBar(content: Text('변경사항이 저장되었습니다.')));
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('MY정보'),
      ),
      body: FutureBuilder(
        future: getUserInfo(),
        builder: (context, snapshot) {
          if(snapshot.hasData == false)
            return CircularProgressIndicator();
          else {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[100],
                          child: ClipOval(
                            child: new SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child: (_image!=null)?Image.file(
                                _image,
                                fit: BoxFit.fill,
                              ):Image.network(
                                "https://flutterawesome.com/favicon.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.photo_camera,
                            size: 30.0,
                          ),
                          onPressed: () {
                            getImage();
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text('이메일',
                            style:
                            TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                        SizedBox(width: 20.0),
                        Text('$emailID',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('닉네임',
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 18.0)),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 150,
                                  child: Form(
                                    key: formKey,
                                    child: TextFormField(
                                        initialValue: '$nickname',
                                        enabled: editable,
                                        onSaved: (String value) {
                                          nickname = value;
                                        },
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                  )
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: NicknameEditWidget()
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('생일',
                                    style: TextStyle(
                                        color: Colors.blueGrey, fontSize: 18.0)),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text('${birthdayDate.year}-${birthdayDate.month}-${birthdayDate.day}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: IconButton(
                            icon: Icon(Icons.create),
                            color: Colors.blueGrey,
                            onPressed: () async {
                              DateTime picked = await showDatePicker(context: context, initialDate: birthdayDate, firstDate: DateTime(DateTime.now().year-70), lastDate: DateTime(DateTime.now().year+1));
                              if(picked != null) {
                                setState(() {
                                  birthdayDate = picked;
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  //
                  /*
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('이메일',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 18.0)),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('michelle123@gmail.com',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      child: Icon(
                        Icons.create,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                ],
              ),
              */
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.yellow,
                        onPressed: () {
                          uploadPic(context);
                        },
                        elevation: 4.0,
                        splashColor: Colors.blue,
                        child: Text(
                          '$save',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MYCERTIPORTFOLIO()));
                        },
                        elevation: 4.0,
                        splashColor: Colors.yellow,
                        child: Text(
                          'MY자격증',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      ),
                      RaisedButton(
                        color: Colors.grey,
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Splash();
                        },
                        elevation: 4.0,
                        splashColor: Colors.yellow,
                        child: Text(
                          '로그아웃',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ), // 포트폴리오 업로드
                ],
              ),
            );
          }
        },
      )
    );
  }

  Widget NicknameEditWidget () {
    if (editable == false)
      return IconButton (
        icon: Icon(Icons.create),
        color: Colors.blueGrey,
        onPressed: () {
          setState(() {
            editable = true;
          });
        },
      );
    else
      return IconButton(
        icon: Icon(Icons.check),
        color: Colors.blueGrey,
        onPressed: () {
          setState(() {
            editable = false;
          });
        },
      );
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
            return MYCERTI();
        }}
    );
  }
}
