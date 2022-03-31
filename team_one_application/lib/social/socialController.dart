import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:team_one_application/filter/filterView.dart';
import 'package:team_one_application/models/friend_ref.dart';
import 'package:team_one_application/social/socialState.dart';
import 'package:firebase_core/firebase_core.dart';

class SocialController extends ChangeNotifier {
  String _uId;
  SocialState socialState;

  FirebaseFirestore? instance_;

  SocialController({required uId})
      : _uId = uId,
        socialState = SocialState() {
    init();
  }

  void init() async {
    fetchFriendsList(_uId).then((value) {
      socialState.setDone(value);
    }).onError((error, stackTrace) {
      print("Error fetching social: $error \n with stacktrace: $stackTrace");
      socialState.setError();
    }).whenComplete(() {
      notifyListeners();
    });
  }

  // Calls to database to get friends displayNames and uIds
  Future<List<FriendRef>?> fetchFriendsList(String uId) async {
    instance_ = FirebaseFirestore.instance;

    CollectionReference friendsData =
        instance_!.collection("users").doc(uId).collection("friends");
    QuerySnapshot snapshot = await friendsData.get();
    final List outputList = snapshot.docs.map((doc) => doc.data()).toList();
    final List<FriendRef> outputData = [];
    for (Map<String, dynamic> element in outputList) {
      outputData.add(
          FriendRef(displayName: element['displayName'], uId: element['uId']));
    }
    return outputData;
  }
}
