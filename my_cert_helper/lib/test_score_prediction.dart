import 'package:flutter/material.dart';
import 'package:mycerthelper/main.dart';
import 'package:mycerthelper/page_study_manage.dart';

class TestScorePrediction extends StatelessWidget{
  static int selected = 0;

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
                itemCount: StudyManagerState.data.certObj.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text(StudyManagerState.data.certObj.elementAt(index).CertName),
                    trailing: IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        selected = index;
                        Navigator.of(context).pushNamed(RECOMMENDATION_TEST_PAGE);
                      },
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


