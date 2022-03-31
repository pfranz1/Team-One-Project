import 'package:flutter/cupertino.dart';
import 'package:team_one_application/schedule/scheduelState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:team_one_application/models/Event.dart';
import 'package:flutter/material.dart';

class ScheduleController extends ChangeNotifier {
  ScheduleState scheduleState;
  final String _uId;

  ScheduleController({required String uId})
      : scheduleState = ScheduleState(uId),
        _uId = uId {
    init();
  }

  void init() async {
    getDataFromFireStore().then((value) {
      scheduleState.setLoaded(value);
    }).onError((error, stackTrace) {
      print("Error fetching schedule: $error \n with stacktrace: $stackTrace");
      scheduleState.setError();
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<List<Event>> getDataFromFireStore() async {
    List<Event> events = <Event>[];
    FirebaseFirestore? _instance;
    _instance = FirebaseFirestore.instance;

    CollectionReference eventCollection =
        _instance.collection("users").doc(_uId).collection("events");

    //Accessing db by uId instead of hard coded userID here
    //Either: delete the top portion & uncomment below
    //        replace hardcoded userID with _uId and delete below
    /*
    CollectionReference eventCollection = _instance
        .collection("users")
        .doc(_uId)
        .collection("events");
        */

    QuerySnapshot querySnapshot = await eventCollection.get();
    final eventObs = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    eventObs.forEach((eventData) {
      Event meet = Event.fromJson(eventData);
      events.add(meet);
    });
    await Future.delayed(const Duration(seconds: 1));
    return events;
  }

  //for future feature to add classes from app
  Future uploadTestData() async {
    final docEvent =
        FirebaseFirestore.instance.collection('CalendarCollection').doc("1");

    final json = {
      'Subject': "Mastering Flutter",
      'StartTime': '22 March 2022 at 08:00:00',
      'EndTime': '22 March 2022 at 09:00:00'
    };

    await docEvent.set(json);
  }
}
