import 'package:flutter/cupertino.dart';
import 'package:team_one_application/models/Event.dart';
import 'package:team_one_application/schedule/scheduelState.dart';

class ScheduleController extends ChangeNotifier {
  ScheduleState scheduleState;
  final String _uId;

  ScheduleController({required String uId})
      : scheduleState = ScheduleState(uId),
        _uId = uId {
    init();
  }

  void init() async {
    fetchSchedule(_uId).then((value) {
      scheduleState.setLoaded(value);
    }).onError((error, stackTrace) {
      print("Error fetching schedule: $error \n with stacktrace: $stackTrace");
      scheduleState.setError();
    }).whenComplete(() {
      notifyListeners();
    });
  }

  // I would love if this was move to a db proxy file inside of this component file
  Future<List<Event>?> fetchSchedule(String uID) async {
    final dummyData = [
      Event(
          name: "Event",
          startTime: "0930A",
          endTime: "1030A",
          location: "HUBERT Hall",
          daysOfWeek: ["m", "w"],
          desc: "Generic Event"),
    ];
    await Future.delayed(Duration(seconds: 2));
    return dummyData;
  }
}
