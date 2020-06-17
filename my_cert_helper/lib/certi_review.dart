
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'information_review_page.dart';


class CertiReview extends StatefulWidget {
  @override
  _CertiReviewState createState() => _CertiReviewState();
}

class _CertiReviewState extends State<CertiReview> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('난이도 평가',  style: TextStyle(fontSize: 20.0, color: Colors.black)), backgroundColor: Colors.yellow,),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border:OutlineInputBorder(),
                labelText: '평가 입력하기'
              ),
              onSubmitted: (String value) async {
                Firestore store = Firestore.instance;
                DocumentSnapshot result;
                QuerySnapshot qResult;
                qResult = await store.collection('/CertList').where('name', isEqualTo: ReviewPageState.certData.name).getDocuments();
                result = qResult.documents.elementAt(0);
                var qID = await FirebaseAuth.instance.currentUser();
               await store.collection('/CertList/'+result.reference.documentID+'/Difficulty').document(qID.email).setData({'score' : value });
               await ReviewPageState.loadCertData();
               setState(() {});
              },

              ), ),

//            Text('평균 점수:' + ReviewPageState.certData.getMean(ReviewPageState.certData.difficulty).toString()),
            Expanded(
              child:ListView.builder(
                itemCount: ReviewPageState.certData.difficultyReview.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration( border: Border.all(color: Colors.black12 ) ),
                    margin: const EdgeInsets.all(10.0),
                    child: Text(ReviewPageState.certData.difficultyReview.elementAt(index),
                      textAlign: TextAlign.left,
                      textScaleFactor: 1.2),
                  );
                })
            ),
          ],
        )
    );
  }


}