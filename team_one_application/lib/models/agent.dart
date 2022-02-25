// Agent implementation

import 'package:team_one_application/models/Event.dart';
import 'package:team_one_application/models/friend_ref.dart';

class Agent {
  // Declarations
  final String name, type, uID;
  final List<Event>? schedule;
  List<FriendRef>? friendList;

  // Agent constructor
  // name (name of individual, required (cannot be null)
  // type (student/teacher)
  // major (can be null (teacher))
  // var friendList (why not tuple?)
  // Schedule<E> (schedule implementation)

  Agent(
      {required this.name,
      required this.type,
      this.friendList,
      this.schedule,
      required this.uID});
}

// Student implementation
class Student extends Agent {
  final String? major;

  Student(
      {required name,
      required type,
      this.major,
      friendList,
      uId,
      required schedule})
      : super(
            name: name,
            type: type,
            uID: uId,
            friendList: friendList,
            schedule: schedule);
}

// Staff implementation
class Staff extends Agent {
  String? officeLocation;

  Staff(
      {required name,
      required type,
      required this.officeLocation,
      required friendList,
      required uID,
      required schedule})
      : super(
            name: name,
            type: type,
            uID: uID,
            friendList: friendList,
            schedule: schedule);
}
