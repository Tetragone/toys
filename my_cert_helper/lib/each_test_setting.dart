import 'package:flutter/material.dart';
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
              ],
            ),
          )
        ],
      ),
    );
  }
}