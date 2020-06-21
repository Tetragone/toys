import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mycerthelper/data_group.dart';

import 'main.dart';

class EachTestSetting extends StatefulWidget{
  @override
  State createState() => EachTestSettingState();
}

class EachTestSettingState extends State<EachTestSetting>{
  CertObjective obj;

  @override
  Widget build(BuildContext context) {
    final Map<String,CertObjective> args = ModalRoute.of(context).settings.arguments;

    if(args['obj'].isTested == null)
      args['obj'].isTested = false;
    if(args['obj'].targetGrade.toString() == null)
      args['obj'].targetGrade = 0;
    if(args['obj'].priority == null)
      args['obj'].priority = 1;
    if(args['obj'].selected == null)
      args['obj'].selected = Colors.yellow;

    if(args['obj'].selected.value == Colors.yellow.value)
      args['obj'].selected = Colors.yellow;
    if(args['obj'].selected.value == Colors.red.value)
      args['obj'].selected = Colors.red;
    if(args['obj'].selected.value == Colors.blue.value)
      args['obj'].selected = Colors.blue;
    if(args['obj'].selected.value == Colors.green.value)
      args['obj'].selected = Colors.green;

    return Scaffold(
      appBar: AppBar(title: Text('${args['obj'].CertName}의 설정'),),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: Text(
                        '응시여부',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                      flex: 1,
                      child: Checkbox(
                        value: args['obj'].isTested ?? false,
                        onChanged: (bool value) {args['obj'].isTested = value; this.setState((){});},
                      )
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Text(
                        '목표 점수/등급',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          initialValue: args['obj'].targetGrade.toString() ?? "0",
                          onChanged: (input) { args['obj'].targetGrade = int.parse(input);this.setState((){});},
                        )
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Text(
                        '우선 순위',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: DropdownButton(
                          value: args['obj'].priority  ?? 1,
                          hint: Text('우선순위!'),
                          items: [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('1순위'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('2순위'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('3순위'),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text('그외'),
                            )
                          ],
                          onChanged: (int index) {args['obj'].priority = index;this.setState((){});},
                        )
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Text(
                        '캘린더 색상 선택',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: DropdownButton<Color>(
                          hint: Text('색상!'),
                          value: args['obj'].selected  ?? Colors.yellow,
                          items: [
                            DropdownMenuItem(
                              value: Colors.yellow,
                              child: Text('노랑'),
                            ),
                            DropdownMenuItem(
                              value: Colors.red,
                              child: Text('빨강'),
                            ),
                            DropdownMenuItem(
                              value: Colors.blue,
                              child: Text('파랑'),
                            ),
                            DropdownMenuItem(
                              value: Colors.green,
                              child: Text('초록'),
                            )
                          ],
                          onChanged: (Color selected) {args['obj'].selected = selected; this.setState((){});},
                        )
                    )
                  ],
                ),

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
                            await store.collection('/ObjectList').document().setData({
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
              ],
            ),
          )
        ],
      ),
    );
  }
}