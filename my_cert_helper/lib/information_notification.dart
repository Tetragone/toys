import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:url_launcher/url_launcher.dart';

import 'calendar_page.dart';

// 시험 알림 페이지

class InfoNotification extends StatefulWidget {
  @override
  _InfoNotificationState createState() => _InfoNotificationState();
}

class _InfoNotificationState extends State<InfoNotification> {
  
  @override
  void initState() {
    // TODO: implement initState
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공지사항')),
      body: _buildBody(context)
    );
  }


  Widget _buildBody(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('testinfo').snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          else {
            return _showTest(context, snapshot.data.documents);
          }
        },
      );
    }

    Widget _showTest(BuildContext context, List<DocumentSnapshot> snapshot) {
      return ListView(
        padding: const EdgeInsets.only(top:20.0),
        children: snapshot.map((data)=> _buildListItem(context,data)).toList()
      );
    }

    Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
      final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.testname),
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey
            )            
          ),
        //  borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(record.testname),
          subtitle: Text(record.testday.toString()),
          trailing: IconButton(
            icon: Icon(Icons.link, color: Colors.blue, size: 35.0), 
            onPressed: () {
              launch(record.link);
            }),
        ),
      ),
    );
    }
}

class Record {
 final String testname;
 final String testday;
 final String link;

 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['testname'] != null),
       assert(map['testday'] != null),
       assert(map['link'] != null),

       testname = map['testname'],
       testday = map['testday'],
       link = map['link'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$testname:$testday:$link>";
}