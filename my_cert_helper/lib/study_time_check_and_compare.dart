import 'package:flutter/material.dart';

class StudyTimeCheckAndCompare extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공부 시간 확인 및 비교'),),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text('test'),
                  trailing: IconButton(
                    icon: Icon(Icons.border_color),
                    onPressed: () => {
                      //Navigator.of(context).pushNamed();
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