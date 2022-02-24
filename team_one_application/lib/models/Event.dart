//Event Superclass
class Event {
  //Instance variables
  String name, startTime, endTime;
  String? location;
  String? desc;
  String type;
  List<String>? daysOfWeek;

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
    required this.location,
    required this.daysOfWeek,
    required this.desc,
    this.type = "generic",
  }) {}
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
      String lName,
      String lStartTime,
      String lEndTime,
      String lLocation,
      List<String> lDaysOfWeek,
      String lDesc,
      this.isOnline,
      this.isInPerson,
      this.isHybrid,
      this.professor,
      this.isSkippable)
      : super(
          name: lName,
          startTime: lStartTime,
          endTime: lEndTime,
          location: lLocation,
          daysOfWeek: lDaysOfWeek,
          desc: lDesc,
          type: "Lecture",
        ) {}
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
  OfficeHour(
    String oName,
    String oStartTime,
    String oEndTime,
    String oLocation,
    List<String> oDaysOfWeek,
    String oDesc,
    bool this.isOnline,
  ) : super(
          name: oName,
          startTime: oStartTime,
          endTime: oEndTime,
          location: oLocation,
          daysOfWeek: oDaysOfWeek,
          desc: oDesc,
          type: "Office Hour",
        ) {}
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
    String cStartTime,
    String cEndTime,
    String cLocation,
    List<String> cDaysOfWeek,
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
}

void main() {}
