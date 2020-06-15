import 'package:flutter/material.dart';
import 'package:link/link.dart';
import 'package:mycerthelper/information_review_page.dart';


class CertiDate extends StatefulWidget {
  @override
  _CertiDateState createState() => _CertiDateState();
}

class _CertiDateState extends State<CertiDate> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('시험일',  style: TextStyle(fontSize: 20.0, color: Colors.black)), backgroundColor: Colors.yellow,),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: ReviewPageState.certData.testTimeList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 50,
                        child: Link(
                            child: Text(ReviewPageState.certData.testTimeList.elementAt(index).time.toString()),
                            url: ReviewPageState.certData.testTimeList.elementAt(index).link
                        ),
                      );
                    })

            )
          ],
        )
    );
  }


}