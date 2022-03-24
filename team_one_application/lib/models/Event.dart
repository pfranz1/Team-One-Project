//Event Superclass
class Event {
  //Instance variables
  String name;
  DateTime startTime, endTime;
  String? location;
  String? desc;
  String? type;
  String? daysOfWeek;

  /*
   * Event Class Constructor
   * --------------------------
   * name-name of event
   * startTime-start time of event
   * endTime-endTime of event
   * location-location of event
   * daysOfWeek-list to store Strings of days of week indicating which days the
   *            event occurs
   * desc-description of event
   * type-overrided type with type of event
   */
  Event({
    required this.name,
    required this.startTime,
    required this.endTime,
    this.location,
    this.daysOfWeek,
    this.desc,
    this.type = "generic",
  }) {}

  Event.fromJson(Map<String, dynamic> json)
      : name = json['Name'],
        startTime = json['StartTime'].toDate(),
        endTime = json['EndTime'].toDate(),
        location = json['Location'],
        desc = json['Description'],
        type = json['Type'],
        daysOfWeek = json['DaysOfWeek'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'startTime': startTime,
        'endTime': endTime,
        'location': location,
        'description': desc,
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
  bool? isSkippable;

  /*
   * Lecture Class Constructor
   * ------------------------------
   * l******-lecture class variables used for super constructor
   * isOnline-bool value to determine if lecture is only online 
   * isInPerson-bool value to determine if lecture is only in-person
   * isHybrid-bool value to determine if lecture is hybrid-mode
   * professor-name of professor teaching lecture
   * isSkippable-bool value for user to determine if lecture is skippable 
   */
  Lecture(
      {required String lName,
      required DateTime lStartTime,
      required DateTime lEndTime,
      required String lLocation,
      required String lDaysOfWeek,
      required String lDesc,
      this.isOnline,
      this.isInPerson,
      this.isHybrid,
      required this.professor,
      this.isSkippable})
      : super(
          name: lName,
          startTime: lStartTime,
          endTime: lEndTime,
          location: lLocation,
          daysOfWeek: lDaysOfWeek,
          desc: lDesc,
          type: "Lecture",
        ) {}

  Lecture.fromJson(Map<String, dynamic> json)
      : isOnline = json['isOnline'],
        isInPerson = json['isInPerson'],
        isHybrid = json['isHybrid'],
        professor = json['professor'],
        isSkippable = json['isSkippable'],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {
        'isOnline': isOnline,
        'isInPerson': isInPerson,
        'isHybrid': isHybrid,
        'professor': professor,
        'isSkippable': isSkippable
      }..addAll(super.toJson());
}

//OfficeHour Class
class OfficeHour extends Event {
  bool isOnline;

  /*
   * OfficeHour Class Constructor
   * ---------------------------------
   * o******-OfficeHour class variables used for super constructor
   * isOnline-bool value to indicate if office hours are online
   */
  OfficeHour({
    required String oName,
    required DateTime oStartTime,
    required DateTime oEndTime,
    required String oLocation,
    required String oDaysOfWeek,
    required String oDesc,
    required bool this.isOnline,
  }) : super(
          name: oName,
          startTime: oStartTime,
          endTime: oEndTime,
          location: oLocation,
          daysOfWeek: oDaysOfWeek,
          desc: oDesc,
          type: "Office Hour",
        ) {}

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
   * c******-ClubMeeting class variables used for super constructors
   * acronym-acronym of the club 
   * clubDesc-club description of the club
   * president-president/leader of the student club
   */
  ClubMeeting(
    String cName,
    DateTime cStartTime,
    DateTime cEndTime,
    String cLocation,
    String cDaysOfWeek,
    String cDesc,
    this.acronym,
  ) : super(
          name: cName,
          startTime: cStartTime,
          endTime: cEndTime,
          location: cLocation,
          daysOfWeek: cDaysOfWeek,
          desc: cDesc,
          type: "Club Meeting",
        ) {}

  ClubMeeting.fromJson(Map<String, dynamic> json)
      : acronym = json['acronym'],
        super.fromJson(json);

  Map<String, dynamic> toJson() => {'acronym': acronym}..addAll(super.toJson());
}

// void main() {
//   List<String> daysOfWeek = ["monday", "tuesday", "wednesday"];
//   Event preEvent = new Event(
//       name: "name",
//       desc: "desc",
//       location: "location",
//       startTime: "startTime",
//       endTime: "endTime",
//       type: "type",
//       daysOfWeek: daysOfWeek);
//   final testJson = preEvent.toJson();
//   Event postEvent = Event.fromJson(testJson);
//   print(postEvent);

//   Lecture preLecture = Lecture(
//       lName: "lName",
//       lStartTime: "lStartTime",
//       lEndTime: "lEndTime",
//       lLocation: "lLocation",
//       lDaysOfWeek: daysOfWeek,
//       lDesc: "lDesc",
//       isOnline: true,
//       isInPerson: false,
//       isHybrid: false,
//       professor: "professor",
//       isSkippable: false);
//   final lTestJson = preLecture.toJson();
//   Lecture postLecture = Lecture.fromJson(lTestJson);
//   print(postLecture);

//   OfficeHour preOffice = OfficeHour(
//       oName: "oName",
//       oStartTime: "oStart",
//       oEndTime: "oEnd",
//       oLocation: "oLoca",
//       oDaysOfWeek: daysOfWeek,
//       oDesc: "oDesc",
//       isOnline: true);
//   final oTest = preOffice.toJson();
//   OfficeHour postOffice = OfficeHour.fromJson(oTest);

//   Event eveOffice = new OfficeHour(
//       oName: "eoName",
//       oStartTime: "eoStartTime",
//       oEndTime: "eoEndTime",
//       oLocation: "eoLocation",
//       oDaysOfWeek: daysOfWeek,
//       oDesc: "eoDesc",
//       isOnline: false);
// }
