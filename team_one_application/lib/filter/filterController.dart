import 'package:flutter/cupertino.dart';
import 'package:team_one_application/filter/filterState.dart';
import 'package:team_one_application/filter/filter_state_enums.dart';
import 'package:team_one_application/models/friend_ref.dart';

class FilterController extends ChangeNotifier {
  String uuId;
  FilterState filterState;

  FilterController({required this.uuId}) : filterState = FilterState() {
    init();
  }

  Future<void> init() async {
    filterState.friendListLoadState = FriendListLoadState.loading;
    notifyListeners();

    //Fetch from db
    fetchFriendRefs().then((friendRefs) {
      filterState.friendRefs = friendRefs;
      filterState.friendListLoadState = FriendListLoadState.done;
    }).onError((error, stackTrace) {
      filterState.friendRefs = null;
      filterState.friendListLoadState = FriendListLoadState.error;
    }).whenComplete(() {
      notifyListeners();
    });

    // filterState.friendListLoadState = FriendListLoadState.done;
  }

  Future<List<FriendRef>?> fetchFriendRefs() async {
    final dummyData = <FriendRef>[
      FriendRef(displayName: "FIRST LAST", uId: "TEST-UID")
    ];
    //Wait 2 seconds then return dummy data
    await Future.delayed(Duration(seconds: 2));
    return dummyData;
  }
}
