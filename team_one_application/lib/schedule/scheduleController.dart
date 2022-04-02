import 'package:flutter/cupertino.dart';
import 'package:team_one_application/models/friend_ref.dart';
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

    CollectionReference eventCollection = FirebaseFirestore.instance
        .collection("users")
        .doc(_uId)
        .collection("events");

    QuerySnapshot querySnapshot = await eventCollection.get();

    final eventObs = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    final eventIterator = EventIterator(eventObs);

    while (eventIterator.moveNext()) {
      events.add(eventIterator.current!);
    }
    return events;
  }

  //for future feature to add classes from app
  Future uploadEventData() async {
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

  Future uploadFriendData() async {
    print("Uploading friend data...");
    final collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(_uId)
        .collection("friends");

    List<FriendRef> friends = [
      FriendRef(
          displayName: "Patti Aymond", uId: "1f6mqBJa05Sle83n4qXRWXpEv4F3")
    ];
    for (FriendRef friend in friends) {
      final json = friend.toJson();
      await collectionRef
          .add(json)
          .then((value) => print("done adding $value"));
    }

    print("Done uploading friend data");
  }
}
