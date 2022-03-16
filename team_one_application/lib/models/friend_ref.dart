class FriendRef {
  late String name;
  late String documentID;

  FriendRef({required this.name, required this.documentID}){}

  bool compareTo(FriendRef friend) {
    return (documentID.compareTo(friend.documentID) == 0);
  }

  String returnName() {
    return name;
  }
  
  String returnID() {
    return documentID;
  }

  FriendRef.fromJson(Map<String, dynamic> json){
    name = json['name'];
    documentID = json['documentID'];
  }

  Map<String, dynamic> toJson() => {
    'name' : name,
    'documentID' : documentID
  };
}
