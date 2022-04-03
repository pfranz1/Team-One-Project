class EventIterator extends Iterator<Event?> {
  List<Map<String, dynamic>>? listOfUnserialized;
  EventIterator(List<Map<String, dynamic>>? this.listOfUnserialized);

  Event? _current;
  int _currentIndex = -1;

  Event deserializeUnknow(Map<String, dynamic> unknown) {
    String? unknownType = unknown['type'];
    print(unknownType);
    switch (unknownType) {
      case "generic":
        return Event.fromJson(unknown);
      case "Lecture":
        return Lecture.fromJson(unknown);
      case "Club Meeting":
        return ClubMeeting.fromJson(unknown);
      default:
        // print("Deserializing and recived type of $unknownType \n");
        // print(unknown);
        return Event.fromJson(unknown);
    }
  }

  @override
  Event? get current => _current;

  @override
  bool moveNext() {
    if (listOfUnserialized == null ||
        _currentIndex == listOfUnserialized!.length - 1) return false;

    _currentIndex++;
    _current = deserializeUnknow(listOfUnserialized![_currentIndex]);
    return true;
  }

  bool hasNext() {
    return (listOfUnserialized != null &&
        _currentIndex < listOfUnserialized!.length - 1);
  }

  Event next() {
    moveNext();
    return _current!;
  }
}

//Event Superclass

class Event {
  //Instance variables
  String name;
  DateTime startTime, endTime;
  String? type;
  String? daysOfWeek;

  /*
   * Event Class Constructor
   * --------------------------
   * name-name of event
   * startTime-start time of event
   * endTime-endTime of event
   * daysOfWeek-list to store Strings of days of week indicating which days the
   *            event occurs
   * type-overrided type with type of event
   */
  Event({
    required this.name,
    required this.startTime,
    required this.endTime,
    this.daysOfWeek,
    this.type = "generic",
  });

  Event.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        startTime = json['startTime'].toDate(),
        endTime = json['endTime'].toDate(),
        type = json['type'],
        daysOfWeek = json['daysOfWeek'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'startTime': startTime,
        'endTime': endTime,
        'type': type,
        'daysOfWeek': daysOfWeek
      };
}

//Lecture Class
class Lecture extends Event {
  bool? isOnline;
  bool? isInPerson;
  bool? isHybrid;
  String professor;

  /*
   * Lecture Class Constructor
   * ------------------------------
   * isOnline-bool value to determine if lecture is only online 
   * isInPerson-bool value to determine if lecture is only in-person
   * isHybrid-bool value to determine if lecture is hybrid-mode
   * professor-name of professor teaching lecture
   * isSkippable-bool value for user to determine if lecture is skippable 
   */
  Lecture(
      {required String name,
      required DateTime startTime,
      required DateTime endTime,
      required String daysOfWeek,
      this.isOnline,
      this.isInPerson,
      this.isHybrid,
      required this.professor})
      : super(
          name: name,
          startTime: startTime,
          endTime: endTime,
          daysOfWeek: daysOfWeek,
          type: "Lecture",
        );

  Lecture.fromJson(Map<String, dynamic> json)
      : isOnline = json['isOnline'],
        isInPerson = json['isInPerson'],
        isHybrid = json['isHybrid'],
        professor = json['professor'],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'isOnline': isOnline,
        'isInPerson': isInPerson,
        'isHybrid': isHybrid,
        'professor': professor,
      }..addAll(super.toJson());
}

//OfficeHour Class
class OfficeHour extends Event {
  bool isOnline;

  /*
   * OfficeHour Class Constructor
   * ---------------------------------
   * isOnline-bool value to indicate if office hours are online
   */
  OfficeHour({
    required String name,
    required DateTime startTime,
    required DateTime endTime,
    required String daysOfWeek,
    required this.isOnline,
  }) : super(
          name: name,
          startTime: startTime,
          endTime: endTime,
          daysOfWeek: daysOfWeek,
          type: "Office Hour",
        );

  OfficeHour.fromJson(Map<String, dynamic> json)
      : isOnline = json['isOnline'],
        super.fromJson(json);

  Map<String, dynamic> toJson() =>
      {'isOnline': isOnline}..addAll(super.toJson());
}

//ClubMeeting Class
class ClubMeeting extends Event {
  String? acronym;

  /*
   * ClubMeeting Class Constructor
   * -----------------------------------
   * acronym-acronym of the club 
   */
  ClubMeeting(
    String name,
    DateTime startTime,
    DateTime endTime,
    String daysOfWeek,
    this.acronym,
  ) : super(
          name: name,
          startTime: startTime,
          endTime: endTime,
          daysOfWeek: daysOfWeek,
          type: "Club Meeting",
        );

  ClubMeeting.fromJson(Map<String, dynamic> json)
      : acronym = json['acronym'],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {'acronym': acronym}..addAll(super.toJson());
}

void main() {
  final tEvent = Event(
      name: "Test",
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      daysOfWeek: "m,t,w,tu");
  List<Map<String, dynamic>> testUnknown = [tEvent.toJson()];
  final myItterator = EventIterator(testUnknown);
  final pEvent = myItterator.next();
  print(pEvent == tEvent);
}
