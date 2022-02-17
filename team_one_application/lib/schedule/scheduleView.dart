import 'package:flutter/material.dart';
import 'package:team_one_application/schedule/scheduelState.dart';
import 'package:team_one_application/schedule/scheduleController.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key? key, required this.scheduleController})
      : super(key: key);

  final ScheduleController scheduleController;

  @override
  Widget build(BuildContext context) {
    return ScheduleVisualElement(state: scheduleController.scheduleState);
  }
}

class ScheduleVisualElement extends StatefulWidget {
  const ScheduleVisualElement({Key? key, required this.state})
      : super(key: key);

  final ScheduleState state;

  @override
  _ScheduleVisualElementState createState() => _ScheduleVisualElementState();
}

class _ScheduleVisualElementState extends State<ScheduleVisualElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('ScheduleView ${widget.state.uId}'),
          if (widget.state.isDone) Text(widget.state.schedule.toString()),
          if (widget.state.isLoading) Text("Loading..."),
          if (widget.state.isError) Text("Error!"),
        ],
      ),
    );
  }
}
