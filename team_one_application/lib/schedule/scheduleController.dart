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
        _uId = uId.trim() {
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
    print("Uploading test data...");
    final collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(_uId)
        .collection("events");

    List<Event> events = [
      Event(
          name: "Test Event2",
          startTime: DateTime.now().subtract(Duration(hours: 2)),
          endTime: DateTime.now(),
          daysOfWeek: "SAT"),
    ];
    for (Event event in events) {
      final json = event.toJson();
      await collectionRef
          .add(json)
          .then((value) => print("done adding $value"));
    }

    print("Done uploading test data");
  }
}
