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
      FriendRef(name: "Mason Brick Jr.", documentID: "USERID-1"),
      FriendRef(name: "Joe Baseball", documentID: "USERID-2"),
      FriendRef(name: "Haymond Money", documentID: "USERID-3"),
      FriendRef(name: "Georgie Longs", documentID: "USERID-4"),
      FriendRef(name: "Steven Danger", documentID: "USERID-5"),
      FriendRef(name: "Elizabeth Smtih", documentID: "USERID-6"),
      FriendRef(name: "Elon Musk", documentID: "USERID-7"),
      FriendRef(name: "Jennifer Lopez", documentID: "USERID-8"),
      FriendRef(name: "Ariana Grande", documentID: "USERID-9"),
      FriendRef(name: "Sam L. Jackson", documentID: "USERID-10"),
      FriendRef(name: "The Rock", documentID: "USERID-11"),
      FriendRef(name: "Caesar", documentID: "USERID-12"),
      FriendRef(name: "Queen Elizabeth", documentID: "USERID-13"),
      FriendRef(name: "Drew Brees", documentID: "USERID-14"),
    ];
    //Wait 2 seconds then return dummy data
    await Future.delayed(Duration(seconds: 2));
    return dummyData;
  }
}
