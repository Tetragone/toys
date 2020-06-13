import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycerthelper/infomation_market_page.dart';

class BoardContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('중고 거래 게시판'),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('제목'),
                      Text(
                        '${marketBoardState.postedContents[marketBoardState.selected].title}',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //작성자가 들어가면 좋을듯함.
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.yellow,
                      width: 1,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 10, height: 10,),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 200,
                    ),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('내용'),
                        Text(
                          '${marketBoardState.postedContents[marketBoardState.selected].contents}',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.yellow,
                      width: 1,
                    ),
                  ),
                ),
              )
            ],
          ),
          //여기에 댓글 기능을 넣어야 한다.
        ],
      ),
    );
  }
}

