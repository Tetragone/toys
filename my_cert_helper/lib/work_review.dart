
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'information_review_page.dart';


class WorkReview extends StatefulWidget {
  @override
  _WorkReviewState createState() => _WorkReviewState();
}

class _WorkReviewState extends State<WorkReview> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('실무활용평가',  style: TextStyle(fontSize: 20.0, color: Colors.black)), backgroundColor: Colors.yellow),
        body: Column(
          children: <Widget>[
            TextField(
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
                await store.collection('/CertList/'+result.reference.documentID+'/Usability').document(qID.email).setData({'score' : value });
                await ReviewPageState.loadCertData();
                setState(() { });
              },

            ),

            Text('평균 점수:' + ReviewPageState.certData.getMean(ReviewPageState.certData.usability).toString()),
            Expanded(
    child: ListView.builder(
                itemCount: ReviewPageState.certData.usability.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Text(ReviewPageState.certData.usability.elementAt(index).toString() + '점'),
                  );
                })
            )
          ],
        )
    );
  }


}