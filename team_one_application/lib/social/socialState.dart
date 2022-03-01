import 'package:team_one_application/models/friend_ref.dart';

enum FriendsLoadState { loading, done, error }

class SocialState {
  List<FriendRef>? _friends;
  FriendsLoadState _friendsLoadState = FriendsLoadState.loading;

  bool get isLoading => _friendsLoadState == FriendsLoadState.loading;
  bool get isDone => _friendsLoadState == FriendsLoadState.done;
  bool get isError => _friendsLoadState == FriendsLoadState.error;

  List<FriendRef>? get freinds => _friends;

  void setLoading() {
    _friendsLoadState = FriendsLoadState.loading;
    _friends = null;
  }

  void setDone(List<FriendRef>? loadedFriends) {
    _friendsLoadState = FriendsLoadState.done;
    _friends = loadedFriends;
  }

  void setError() {
    _friendsLoadState = FriendsLoadState.error;
    _friends = null;
  }
}
