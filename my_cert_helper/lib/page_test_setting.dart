import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'main.dart';

class TestSettingPage extends StatefulWidget{

  @override
  State createState() => TestSettingPageState();
}

class TestSettingPageState extends State<TestSettingPage>{
  Firestore firestore = Firestore.instance;
  Stream<QuerySnapshot> currentStream;


  @override
  void initState() {
    super.initState();
    currentStream = firestore.collection("test").snapshots();
  }

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
            StreamBuilder(
              stream: currentStream,
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return  CircularProgressIndicator();
                }

                List<DocumentSnapshot> documents = snapshot.data.documents;
                //DocumentSnapshot 이란? cloud firestore에서 데이터를 가져오기 위한 형식 정도로 생각!
                int length = documents.length;

                return Flexible(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(length, (index) {
                      return RaisedButton( //뒤에 배경 이미지를 넣을려면 container로 바꿔서 구현해야한다.
                        child: Text('${documents[index].data["name"]}'),
                        color: Colors.limeAccent,
                        onPressed: () {Navigator.of(context).pushNamed(EACH_TEST_SETTING
                        , arguments:<String, String> {'title' : documents[index].data["name"]},);},
                      );
                    })
                  ),
                );
              },
            ),
          ],
        )
    );
  }
}
