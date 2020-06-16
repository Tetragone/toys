import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class marketBoard extends StatefulWidget {

  @override
  State createState() => marketBoardState();
}

class marketBoardState extends State<marketBoard> {
  Firestore firestore = Firestore.instance;
  static List<PostedContents> postedContents = List();
  QuerySnapshot qSnap;
  List<DocumentSnapshot> docList;
  Iterator<DocumentSnapshot> docIter;
  String titleTemp;
  String contentsTemp;
  String emailTemp;
  PostedContents postedContentsTemp;
  static int selected = 0;

  @override
  void initState() {
    super.initState();
    postedContents = List();
  }

  getBoardTitle() async {
    postedContents = List();

    qSnap = await firestore.collection("Board").getDocuments();
    docList = qSnap.documents;
    docIter = docList.iterator;

    while(docIter.moveNext() == true) {
      titleTemp = docIter.current.data['title'];
      contentsTemp = docIter.current.data['contents'];
      emailTemp = docIter.current.data['userEmail'];
      postedContentsTemp = PostedContents(titleTemp, contentsTemp, emailTemp);
      postedContents.add(postedContentsTemp);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('중고 거래 게시판'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.autorenew),
            tooltip: '새로 고침',
            onPressed: () {
              setState(() {
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Next page',
            onPressed: () {
              Navigator.of(context).pushNamed(ADD_NEW_BOARD_CONTEXTS);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: getBoardTitle(),
        builder: (context ,snapshot) {
          if(snapshot.hasData == false)
            return CircularProgressIndicator();
          else {
            return Container(
              child: ListView.builder(
                itemCount: postedContents.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('${index + 1}. ${postedContents[index].title}'),
                    onTap: () {
                      selected = index;
                      Navigator.of(context).pushNamed(BOARD_CONTENTS);
                    },
                  );
                },
              ),
            );
          }
        },
      )
    );
  }
}

class PostedContents {
  String title;
  String contents;
  String email;

  PostedContents(String title, String contents, String email) {
    this.title = title;
    this.contents = contents;
    this.email = email;
  }
}