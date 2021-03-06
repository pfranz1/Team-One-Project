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

    // Go to the event collection in user
    CollectionReference eventCollection = FirebaseFirestore.instance
        .collection("users")
        .doc(_uId)
        .collection("events");

    // Get every document there
    QuerySnapshot querySnapshot = await eventCollection.get();

    // Convert each doc to a map and store in a list
    final docMaps = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    // Pass list of maps to itterator to delegate deserialization
    final eventIterator = EventIterator(docMaps);

    // Utilize iterator to get event objects
    while (eventIterator.moveNext()) {
      events.add(eventIterator.current!);
    }
    // Printing for debug
    // events.forEach((element) {
    //  print(element.toJson());
    // });

    // Return
    return events;
  }

  Future uploadEventData() async {
    print("Uploading test data...");
    final collectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(_uId)
        .collection("events");

    List<Event> events = [
      ClubMeeting(
        name: "Club meeting",
        startTime: DateTime.now().subtract(Duration(hours: 2)),
        endTime: DateTime.now(),
        daysOfWeek: "SUN",
        acronym: "SASE",
      ),
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
