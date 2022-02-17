import 'package:flutter/material.dart';
import 'package:team_one_application/schedule/scheduleController.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key? key, required this.scheduleController})
      : super(key: key);

  final ScheduleController scheduleController;

  @override
  Widget build(BuildContext context) {
    final state = scheduleController.scheduleState;
    return Container(
      child: Column(
        children: [
          Text('ScheduleView ${state.uId}'),
          if (state.isDone) Text(state.schedule.toString()),
          if (state.isLoading) Text("Loading..."),
          if (state.isError) Text("Error!"),
        ],
      ),
    );
  }
}
