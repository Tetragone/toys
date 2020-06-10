import 'package:firebase_helpers/firebase_helpers.dart';
import 'calendar_model_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

DatabaseService<EventModel> eventDBS = DatabaseService<EventModel>("events",fromDS: (id,data) => EventModel.fromDS(id, data), toMap:(event) => event.toMap());

class FirestoreService {
  static final FirestoreService _firestoreService =
      FirestoreService._internal();
  Firestore _db = Firestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Future<void> deleteNote(String id) {
    return _db.collection('events').document(id).delete();
  }

}