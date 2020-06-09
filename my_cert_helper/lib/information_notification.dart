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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildBody(context),
      )
    );
  }


  Widget _buildBody(BuildContext context) {
      return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('info_notification').snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return LinearProgressIndicator();
          }
          else {
            return _showNoti(context, snapshot.data.documents);
          }
        },
      );
    }

    Widget _showNoti(BuildContext context, List<DocumentSnapshot> snapshot) {
      return ListView(
        padding: const EdgeInsets.only(top:20.0),
        children: snapshot.map((data)=> _buildListItem(context,data)).toList()
      );
    }

    Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
      final record = Record.fromSnapshot(data);

    return Padding(
      key: ValueKey(record.title),
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
          title: Text(record.title),
          subtitle: Text(record.subtitle.toString()),
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
 final String title;
 final String subtitle;
 final String link;

 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['title'] != null),
       assert(map['subtitle'] != null),
       assert(map['link'] != null),

       title = map['title'],
       subtitle = map['subtitle'],
       link = map['link'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$title:$subtitle:$link>";
}