import 'package:flutter/material.dart';
import 'package:mycerthelper/main.dart';

class TestScorePrediction extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공부 방법 추천'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text('test'),
                    trailing: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => {Navigator.of(context).pushNamed(RECOMMENDATION_TEST_PAGE)},
                    ),
                  );
                },
              ),
          ),
        ],
      ),
    );
  }
}

//enum SingingCharacter { yes, no }
//
//class testContainer extends Container {
//  final String testQuestion;
//  int answer;
//  SingingCharacter _character = SingingCharacter.yes;
//
//
//  testContainer(String question, BuildContext context)
//      : testQuestion = question,
//        super(
//        child: Column(
//          children: <Widget>[
//            Text('${question}'),
//            Row(
//              children: <Widget>[
//                ListTile(
//                  title: Text('yes'),
//                  leading: Radio(
//                    value: SingingCharacter.yes,
//                    groupValue: _character,
//                    onChanged: (SingingCharacter value) {
//                      setState(() {
//                        _character = value;
//                      });
//                    },
//                  ),
//                ),
//                ListTile(
//                  title: const Text('no'),
//                  leading: Radio(
//                    value: SingingCharacter.no,
//                    groupValue: _character,
//                    onChanged: (SingingCharacter value) {
//                      setState(() {
//                        _character = value;
//                      });
//                    },
//                  ),
//                ),
//              ],
//            )
//          ]
//        )
//      );
//}

