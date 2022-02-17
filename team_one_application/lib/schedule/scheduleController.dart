import 'package:flutter/cupertino.dart';
import 'package:team_one_application/schedule/scheduelState.dart';

class ScheduleController extends ChangeNotifier {
  ScheduleState scheduleState;
  final String _uId;

  ScheduleController({required String uId})
      : scheduleState = ScheduleState(uId),
        _uId = uId;

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
  Future<List<String>?> fetchSchedule(String uID) async {
    final dummyData = ["Event One", "Event Two", "Event Three"];
    await Future.delayed(Duration(seconds: 5));
    return dummyData;
  }
}
