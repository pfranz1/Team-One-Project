import 'package:team_one_application/models/Event.dart';
import 'package:team_one_application/models/friend_ref.dart';

// Agent superclass
class Agent {
  // Declarations
  final String name, type, uID;
  final List<Event>? schedule;
  List<FriendRef>? friendList;

  /*
	 * Agent constructor
	 * -----------------
	 * name - name of agent
	 * type - type of agent
	 * uID - user ID
	 * friendList - list of friend, can be null
	 * schedule - schedule implementation, can be null
	*/
  Agent(
      {required this.name,
      required this.type,
      this.friendList,
      this.schedule,
      required this.uID});

  Agent.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        type = json['type'],
        friendList = json['friendList'],
        schedule = json['schedule'],
        uID = json['uID'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'friendList': friendList,
        'schedule': schedule,
        'uID': uID,
      };
}

// Student class
class Student extends Agent {
  final String? major;

/* Student constructor
 * -------------------
 * super variables (name, type, major, friendList, uID, schedule)
 * major - student's major, can be null
*/
  Student(
      {required name,
      required type,
      this.major,
      friendList,
      uID,
      required schedule})
      : super(
            name: name,
            type: type,
            uID: uID,
            friendList: friendList,
            schedule: schedule);

  Student.fromJson(Map<String, dynamic> json)
      : major = json['major'],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'major': major,
      }..addAll(super.toJson());
}

// Staff class
class Staff extends Agent {
  String? officeLocation;

/* Staff constructor
 * super variables (name, type, major, friendList, uID, schedule)
 * officeLocation - String of individual's office, can be null
*/
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

  Staff.fromJson(Map<String, dynamic> json)
      : officeLocation = json['officeLocation'],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'officeLocation': officeLocation,
      }..addAll(super.toJson());
}
