import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addNewBoardContext extends StatefulWidget{

  @override
  State createState() => addNewBoardContextState();
}

class addNewBoardContextState extends State<addNewBoardContext> {
  String _title;
  String _contexts;
  final formKey = GlobalKey<FormState>();
  Firestore firestore = Firestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String email_Id;

  @override
  void initState() {
    super.initState();

    firebaseAuth.onAuthStateChanged
        .firstWhere((user) => user != null)
        .then((user) {
      email_Id = user.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('게시글 추가'),),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '제목을 입력해주세요!',
                    labelText: '제목',
                    border: InputBorder.none,
                  ),
                  onSaved: (String value) {
                    _title = value;
                  },
                  validator: (value) {
                    if(value.isEmpty) {
                      return '제목 입력을 하지 않았습니다!';
                    }
                    return null;
                  },
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.yellow,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                margin: EdgeInsets.all(20),
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: '내용을 입력해주세요!',
                      labelText: '내용',
                      border: InputBorder.none
                  ),
                  onSaved: (String value) {
                    _contexts = value;
                  },
                  minLines: 3,
                  maxLines: 8,
                  validator: (value) {
                    if(value.isEmpty) {
                      return '내용을 작성 안하셨습니다!';
                    }
                    return null;
                  },
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.yellow,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                margin: EdgeInsets.all(20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('등록'),
                    onPressed: () {
                      if(formKey.currentState.validate()) {
                        formKey.currentState.save();

                        firestore.collection('Board').add({
                          'title': "$_title",
                          'contents' : "$_contexts",
                          'userEmail' : '$email_Id',
                        });

                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  RaisedButton(
                    child: Text('취소'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}