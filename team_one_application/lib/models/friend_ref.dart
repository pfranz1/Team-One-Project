class FriendRef {
  late String displayName;
  late String uId;

  FriendRef({required this.displayName, required this.uId}) {}

  bool compareTo(FriendRef friend) {
    return (uId.compareTo(friend.uId) == 0);
  }

  String returnName() {
    return displayName;
  }

  String returnID() {
    return uId;
  }

  FriendRef.fromJson(Map<String, dynamic> json) {
    displayName = json['name'];
    uId = json['documentID'];
  }

  Map<String, dynamic> toJson() => {'displayName': displayName, 'uId': uId};
}
