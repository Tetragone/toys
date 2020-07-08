import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseHandler {
  Firestore firestore = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  String emailID;
  List<DocumentSnapshot> objectDocSnap;
  List<DocumentSnapshot> boardDocSnap;
  QuerySnapshot querySnapshot;

  Future<String> getEmailID() async {
    if(emailID == null) {
      auth.onAuthStateChanged
          .firstWhere((user) => user != null)
          .then((user) {
        emailID = user.email;
      });
    }

    return emailID;
  }

  Future<List<DocumentSnapshot>> getObjectList(String userEmailID, [String certName = '지정 안됨']) async {
    if (certName == '지정 안됨') {
      querySnapshot = await firestore.collection('objectList')
          .where('user', isEqualTo: userEmailID).getDocuments();
      objectDocSnap = querySnapshot.documents;

      return objectDocSnap;
    }
    else {
      querySnapshot = await firestore.collection('objectList')
          .where('user', isEqualTo: userEmailID).where('certName', isEqualTo: certName).getDocuments();
      objectDocSnap = querySnapshot.documents;

      return objectDocSnap;
    }
  }

  Future<List<DocumentSnapshot>> getBoard() async {
    querySnapshot = await firestore.collection('Board').getDocuments();
    boardDocSnap = querySnapshot.documents;

    return boardDocSnap;
  }

  Future<bool> deleteBoardContents(String title, String userID) async {
    Firestore.instance.collection("Board")
        .where("title", isEqualTo: title).where('userEmail', isEqualTo: userID)
        .getDocuments().then((QuerySnapshot qs) {
      qs.documents.forEach((element) {
        String deleteBoardContext = element.documentID;

        Firestore.instance.collection("Board").document("$deleteBoardContext").delete();
        return true;
      });
    });
  }
}