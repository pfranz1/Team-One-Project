import 'package:flutter/material.dart';
import 'package:team_one_application/schedule/scheduleController.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key? key, required this.scheduleController})
      : super(key: key);

  final ScheduleController scheduleController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('ScheduleView ${scheduleController.scheduleState.uId}'),
    );
  }
}
