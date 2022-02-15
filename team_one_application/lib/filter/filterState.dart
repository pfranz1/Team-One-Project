import 'package:team_one_application/filter/filter_state_enums.dart';
import 'package:team_one_application/models/friend_ref.dart';

class FilterState {
  List<FriendRef>? friendRefs;
  FriendListLoadState friendListLoadState = FriendListLoadState.loading;

  void setFriendRefs(List<FriendRef>? loadedFiendRefs) {
    friendRefs = loadedFiendRefs;
    friendListLoadState = FriendListLoadState.done;
  }

  void failedFriendRefs(_) {
    friendRefs = null;
    friendListLoadState = FriendListLoadState.error;
  }

  bool get isLoaded {
    return friendListLoadState == FriendListLoadState.loading;
  }

  bool get isError {
    return friendListLoadState == FriendListLoadState.error;
  }
}
