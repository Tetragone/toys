import 'package:flutter/material.dart';

class TestScorePrediction extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('자격증 점수 예측'),),
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
                      onPressed: () => {},
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