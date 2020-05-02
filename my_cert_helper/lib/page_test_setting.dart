import 'package:flutter/material.dart';

import 'main.dart';

class TestSettingPage extends StatefulWidget{

  @override
  State createState() => TestSettingPageState();
}

class TestSettingPageState extends State<TestSettingPage>{

  @override
  Widget build(BuildContext context ){
    return Scaffold(
        appBar: AppBar(title: Text('응시 자격증 설정'),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => {},
                ),
                hintText: '자격증을 입력해주세요!',
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text('설정된 자격증'),
            ),
            Flexible(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(100, (index) {
                  return RaisedButton(
                    child: Text('item $index'),
                    onPressed: () {Navigator.of(context).pushNamed(EACH_TEST_SETTING);},
                  );
                })
              ),
            ),
          ],
        )
    );
  }
}