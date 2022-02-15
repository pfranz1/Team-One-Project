import 'package:team_one_application/filter/filter_state_enums.dart';
import 'package:team_one_application/models/friend_ref.dart';

class FilterState {
  List<FriendRef>? friendRefs;
  FriendListLoadState friendListLoadState = FriendListLoadState.loading;

  set didLoadFriendRefs(List<FriendRef>? loadedFiendRefs) {
    friendRefs = loadedFiendRefs;
    friendListLoadState = FriendListLoadState.done;
  }

  set failedLoadFriendRefs(_) {
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
