import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'calendar_page.dart';

// 시험 알림 페이지

class InfoNotification extends StatefulWidget {
  @override
  _InfoNotificationState createState() => _InfoNotificationState();
}

class _InfoNotificationState extends State<InfoNotification> {
  
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();
  Map<String, dynamic> fcm_message;  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        fcm_message = message;
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        fcm_message = message;
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        fcm_message = message;
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('공지사항')),
      body: ListTile(
        title: Text(fcm_message['notification']['title']),
        subtitle: Text(fcm_message['notification']['body']),
      ),
    );
  }
}


/*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(), 
                child: Text('확인', style: TextStyle(color: Colors.black)),
              )
            ],
          )
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
*/