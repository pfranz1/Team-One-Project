import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:team_one_application/filter/filterState.dart';
import 'package:team_one_application/filter/filter_state_enums.dart';
import 'package:team_one_application/models/friend_ref.dart';
import 'package:firebase_core/firebase_core.dart';

class FilterController extends ChangeNotifier {
  String uuId;
  FilterState filterState;

  FirebaseFirestore? instance_;

  final void Function(String) onAgentSelect;

  FilterController({required this.uuId, required this.onAgentSelect})
      : filterState = FilterState() {
    init();
  }

  Future<void> init() async {
    // FilterState at this time is loading (not in error) and has a null for its list of friendRefs

    //Fetch from db
    fetchFriendRefs().then((friendRefs) {
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

  Future<List<FriendRef>?> fetchFriendRefs() async {
    instance_ = FirebaseFirestore.instance;

    CollectionReference friendsData = instance_!
        .collection("users")
        .doc("Dg9ejfmec4YY2on76nTbJAROrLB3")
        .collection("friends");
    QuerySnapshot snapshot = await friendsData.get();
    final List outputList = snapshot.docs.map((doc) => doc.data()).toList();
    // as List<Map<String, dynamic>>;
    final List<FriendRef> outputData = [];
    for (Map<String, dynamic> element in outputList) {
      outputData.add(
          FriendRef(displayName: element['displayName'], uId: element['uId']));
    }
    return outputData;

    // data.map((doc) => outputList.add(FriendRef(displayName:  uId: uId)));

    /* dummyData = <FriendRef>[
      FriendRef(displayName: "Mason Brick Jr.", uId: "USERID-1"),
      FriendRef(displayName: "Joe Baseball", uId: "USERID-2"),
      FriendRef(displayName: "Haymond Money", uId: "USERID-3"),
      FriendRef(displayName: "Georgie Longs", uId: "USERID-4"),
      FriendRef(displayName: "Steven Danger", uId: "USERID-5"),
      FriendRef(displayName: "Elizabeth Smtih", uId: "USERID-6"),
      FriendRef(displayName: "Elon Musk", uId: "USERID-7"),
      FriendRef(displayName: "Jennifer Lopez", uId: "USERID-8"),
      FriendRef(displayName: "Ariana Grande", uId: "USERID-9"),
      FriendRef(displayName: "Sam L. Jackson", uId: "USERID-10"),
      FriendRef(displayName: "The Rock", uId: "USERID-11"),
      FriendRef(displayName: "Caesar", uId: "USERID-12"),
      FriendRef(displayName: "Queen Elizabeth", uId: "USERID-13"),
      FriendRef(displayName: "Drew Brees", uId: "USERID-14"),
    ];
    //Wait 2 seconds then return dummy data
    await Future.delayed(Duration(seconds: 2));
    return dummyData;*/
  }
}
