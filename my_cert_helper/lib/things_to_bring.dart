
import 'package:flutter/material.dart';
import 'package:link/link.dart';

import 'information_review_page.dart';


class ThingsToBring extends StatefulWidget {
  @override
  _ThingsToBringState createState() => _ThingsToBringState();
}

class _ThingsToBringState extends State<ThingsToBring> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('시험준비물',  style: TextStyle(fontSize: 20.0, color: Colors.black)), backgroundColor: Colors.yellow,),
        body: Column(
          children: <Widget>[
            Link(
                        child: Text(ReviewPageState.certData.prepare),
                        url: ReviewPageState.certData.prepareLink
                    ),
    ]
    )
    );
  }
}
