import 'package:team_one_application/filter/filter_state_enums.dart';
import 'package:team_one_application/models/friend_ref.dart';

class FilterState {
  List<FriendRef>? friendRefs;
  FriendListLoadState friendListLoadState = FriendListLoadState.loading;
}
