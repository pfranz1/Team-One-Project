import 'package:flutter/cupertino.dart';
import 'package:team_one_application/models/friend_ref.dart';
import 'package:team_one_application/social/socialState.dart';

class SocialController extends ChangeNotifier {
  String _uId;
  SocialState socialState;

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

  // I would love if this was move to a db proxy file inside of this component file
  Future<List<FriendRef>?> fetchFriendsList(String uID) async {
    final dummyData = <FriendRef>[
      FriendRef(displayName: "Mason Brick Jr.", uId: "USERID-1"),
      FriendRef(displayName: "Joe Baseball", uId: "USERID-2"),
      FriendRef(displayName: "Haymond Money", uId: "USERID-3"),
      FriendRef(displayName: "Georgie Longs", uId: "USERID-4"),
    ];
    await Future.delayed(Duration(seconds: 2));
    return dummyData;
  }
}
