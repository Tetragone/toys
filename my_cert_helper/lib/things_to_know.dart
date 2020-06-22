
import 'package:flutter/material.dart';
import 'package:link/link.dart';

import 'information_review_page.dart';


class ThingsToKnow extends StatefulWidget {
  @override
  _ThingsToKnowState createState() => _ThingsToKnowState();
}

class _ThingsToKnowState extends State<ThingsToKnow> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('시험 주의사항',  style: TextStyle(fontSize: 20.0, color: Colors.black)), backgroundColor: Colors.yellow,),
        body: Container(
          margin: const EdgeInsets.all(10.0),
            child:
              Link(
                  child: Text(ReviewPageState.certData.rule.replaceAll("\\n", "\n"),
                    textAlign: TextAlign.left,
                    textScaleFactor: 1.2,),
                  url: ReviewPageState.certData.ruleLink
              ),

        )
    );
  }
}