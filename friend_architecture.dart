class FriendRef {
  String name = "";
  String documentID = "";

  FriendRef(this.name, this.documentID);

  bool compareTo(FriendRef friend) {
    return (documentID.compareTo(friend.documentID) == 0);
  }

  String returnName() {
    return name;
  }
  
  String returnID() {
    return documentID;
  }
}


// Messed around with a FriendList class, keeping it in case the implementation could inspire
class FriendList {
  var fl = [];

  void friendAdd(FriendRef friend) {
    fl.add(friend);
  }

  bool findFriend(FriendRef friend) {
    for (var fren in fl) {
      if (fren.compareTo(friend)) {
        return true;
      }
    }
    return false;
  }
}
