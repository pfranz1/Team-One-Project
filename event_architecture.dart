//Event Superclass
class Event {
  //Instance variables
  String? name, startTime, endTime, location;
  List? daysOfWeek;

  /*
   * Event Class Constructor
   * 
   * name-name of event
   * startTime-start time of event
   * endTime-endTime of event
   * location-location of event
   * daysOfWeek-list meant to store 7 bool values to represent if event
   *            occurs on certain day of the week
   */
  Event(String this.name, String this.startTime, String this.endTime,
      String this.location, List this.daysOfWeek) {}

  void printInfo() {
    print("Event: $name $startTime $endTime $location");
  }
}

//Lecture Class
class Lecture extends Event {
  bool online;
  bool inPerson;
  bool hybrid;
  String professor;
  bool skippable;

  /*
   * Lecture Class Constructor
   * l******-lecture class variables used for super constructor
   * online-bool value to determine if lecture is only online 
   * inPerson-bool value to determine if lecture is only in-person
   * hybrid-bool value to determine if lecture is hybrid-mode
   * professor-name of professor teaching lecture
   * skippable-bool value for user to determine if lecture is skippable 
   *           (i.e. attendence not req., asynchronous, etc)
   */
  Lecture(
      String lName,
      String lStartTime,
      String lEndTime,
      String lLocation,
      List lDaysOfWeek,
      bool this.online,
      bool this.inPerson,
      bool this.hybrid,
      String this.professor,
      bool this.skippable)
      : super(lName, lStartTime, lEndTime, lLocation, lDaysOfWeek) {}

  void printInfo() {
    super.printInfo();
  }
}

//OfficeHour Class
class OfficeHour extends Event {
  bool online;

  /*
   * OfficeHour Class Constructor
   * 
   * o******-OfficeHour class variables used for super constructor
   * online-bool value to indicate if office hours are online
   */
  OfficeHour(String oName, String oStartTime, String oEndTime, String oLocation,
      List oDaysOfWeek, Object oType, bool this.online)
      : super(oName, oStartTime, oEndTime, oLocation, oDaysOfWeek) {}
}

//ClubMeeting Class
class ClubMeeting extends Event {
  String? acronym;
  String? clubDesc;
  String president;

  /*
   *ClubMeeting Class Constructor
   *
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
      List cDaysOfWeek,
      Object cType,
      String this.acronym,
      String this.clubDesc,
      String this.president)
      : super(cName, cStartTime, cEndTime, cLocation, cDaysOfWeek) {}
}

void main() {
  List<bool> daysOfWeek = List.filled(7, false);
  Event a = new Event("CSC3380", "10:30", "12:00", "PFT1100", daysOfWeek);
  Event b = new Lecture("CSC3380", "10:30", "12:00", "PFT1100", daysOfWeek,
      false, false, false, "Aymond", false);
  a.printInfo();
  print("\n");
}
