import 'package:flutter/cupertino.dart';
import 'package:team_one_application/schedule/scheduelState.dart';

class ScheduleController extends ChangeNotifier {
  ScheduleState scheduleState;
  final String _uId;

  ScheduleController({required String uId})
      : scheduleState = ScheduleState(),
        _uId = uId {
    scheduleState.setuId(_uId);
  }
}
