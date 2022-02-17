class ScheduleState {
  late final String _uId;

  ScheduleState();

  void setuId(String newUId) {
    _uId = newUId;
  }

  get uId => _uId;
}
