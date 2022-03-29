import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:team_one_application/filter/filterState.dart';
import 'package:team_one_application/filter/filter_state_enums.dart';
import 'package:team_one_application/models/friend_ref.dart';
import 'package:firebase_core/firebase_core.dart';

class FilterController extends ChangeNotifier {
  String uId;
  FilterState filterState;

  FirebaseFirestore? instance_;

  final void Function(String) onAgentSelect;

  FilterController({required this.uId, required this.onAgentSelect})
      : filterState = FilterState() {
    init();
  }

  Future<void> init() async {
    // FilterState at this time is loading (not in error) and has a null for its list of friendRefs

    //Fetch from db
    fetchFriendRefs(uId).then((friendRefs) {
      filterState.setFriendRefs(friendRefs);
    }).onError((error, stackTrace) {
      filterState.failedFriendRefs();
    }).whenComplete(() {
      notifyListeners();
    });
  }

  void onFilterSelect(String uId) {
    onAgentSelect(uId);
  }

  Future<List<FriendRef>?> fetchFriendRefs(String uId) async {
    instance_ = FirebaseFirestore.instance;

    CollectionReference friendsData =
        instance_!.collection("users").doc(uId).collection("friends");
    QuerySnapshot snapshot = await friendsData.get();
    final List outputList = snapshot.docs.map((doc) => doc.data()).toList();
    // as List<Map<String, dynamic>>;
    final List<FriendRef> outputData = [];
    for (Map<String, dynamic> element in outputList) {
      outputData.add(
          FriendRef(displayName: element['displayName'], uId: element['uId']));
    }
    return outputData;
  }
}
