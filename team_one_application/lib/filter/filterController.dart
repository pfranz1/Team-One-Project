import 'package:flutter/cupertino.dart';
import 'package:team_one_application/filter/filterState.dart';
import 'package:team_one_application/filter/filter_state_enums.dart';
import 'package:team_one_application/models/friend_ref.dart';

class FilterController extends ChangeNotifier {
  String uuId;
  FilterState filterState;

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
    final dummyData = <FriendRef>[
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
    return dummyData;
  }
}
