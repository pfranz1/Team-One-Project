class FriendRef {
  late String displayName;
  late String uId;

  // Constructor
  FriendRef({required this.displayName, required this.uId}) {}

  // Compare function. Useful for checking if a friend exists in a user's friend list
  bool compareTo(FriendRef friend) {
    return (uId.compareTo(friend.uId) == 0);
  }

  String returnName() {
    return displayName;
  }

  String returnID() {
    return uId;
  }

  // Decoding
  FriendRef.fromJson(Map<String, dynamic> json) {
    displayName = json['name'];
    uId = json['documentID'];
  }

  // Encoding
  Map<String, dynamic> toJson() => {'displayName': displayName, 'uId': uId};
}
