// json 직렬화
import 'dart:convert';
import 'package:flutter/material.dart';

// 캘린더 플러그인
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

// shared_preferences(key-value) 플러그인 : DB 저장, 읽기
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'calendar_page.dart';
import 'calendar_edit_event.dart';

import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem{
  final String id;
  final String title;
  final DateTime eventDate;

  EventModel({this.id,this.title, this.eventDate}):super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      eventDate: data['event_date'],
    );
  }

  factory EventModel.fromDS(String id, Map<String,dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      eventDate: data['event_date'].toDate(),
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "title":title,
      "event_date":eventDate,
      "id":id,
    };
  }
}
