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

  Future<List<FriendRef>?> fetchFriendRefs() async {
    final dummyData = <FriendRef>[
      FriendRef(displayName: "Mason Brick Jr.", uId: "TEST-UID"),
      FriendRef(displayName: "Joe Baseball", uId: "TEST-UID"),
      FriendRef(displayName: "Haymond Money", uId: "TEST-UID"),
      FriendRef(displayName: "Georgie Longs", uId: "TEST-UID"),
    ];
    //Wait 2 seconds then return dummy data
    await Future.delayed(Duration(seconds: 2));
    return dummyData;
  }
}
