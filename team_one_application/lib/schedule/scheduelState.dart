import 'package:team_one_application/schedule/schedule_state_enums.dart';
import 'package:team_one_application/models/Event.dart';

class ScheduleState {
  late final String _uId;

  AgentInfoLoadState _agentInfoLoadState;
  List<Event>? _schedule;

  ScheduleState(String uId)
      : _uId = uId,
        _agentInfoLoadState = AgentInfoLoadState.loading;

  void setuId(String newUId) {
    _uId = newUId;
  }

  void setError() {
    _agentInfoLoadState = AgentInfoLoadState.error;
  }

  void setLoaded(List<Event>? loadedSchedule) {
    _agentInfoLoadState = AgentInfoLoadState.done;
    _schedule = loadedSchedule;
  }

  get isDone => _agentInfoLoadState == AgentInfoLoadState.done;
  get isError => _agentInfoLoadState == AgentInfoLoadState.error;
  get isLoading => _agentInfoLoadState == AgentInfoLoadState.loading;

  get schedule => _schedule;

  get uId => _uId;
}
