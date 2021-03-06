import 'package:team_one_application/filter/filter_state_enums.dart';
import 'package:team_one_application/models/friend_ref.dart';

class FilterState {
  List<FriendRef>? _friendRefs;
  FriendListLoadState _friendListLoadState = FriendListLoadState.loading;

  void setFriendRefs(List<FriendRef>? loadedFiendRefs) {
    _friendRefs = loadedFiendRefs;
    _friendListLoadState = FriendListLoadState.done;
  }

  void failedFriendRefs() {
    _friendRefs = null;
    _friendListLoadState = FriendListLoadState.error;
  }

  bool get isDone {
    return _friendListLoadState == FriendListLoadState.done;
  }

  bool get isError {
    return _friendListLoadState == FriendListLoadState.error;
  }

  bool get isLoading {
    return _friendListLoadState == FriendListLoadState.loading;
  }

  List<FriendRef>? get friendRefs => _friendRefs;
  FriendListLoadState get loadState => _friendListLoadState;
}
