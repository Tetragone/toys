import 'package:flutter/material.dart';

class EachTestSetting extends StatefulWidget{

  @override
  State createState() => EachTestSettingState();
}

class EachTestSettingState extends State<EachTestSetting>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('xx의 설정'),),
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
                        value: false,
                        onChanged: (bool value) {},
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
                          onChanged: (int index) => {},
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
                        child: DropdownButton(
                          hint: Text('색상!'),
                          value: 4,
                          items: [
                            DropdownMenuItem(
                              value: 1,
                              child: Text('노랑'),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text('빨강'),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text('파랑'),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text('초록'),
                            )
                          ],
                          onChanged: (int index) => {},
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