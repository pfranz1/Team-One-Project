import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/models/Event.dart';
import 'package:team_one_application/schedule/scheduelState.dart';
import 'package:team_one_application/schedule/scheduleController.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({Key? key, required this.scheduleController})
      : super(key: key);

  final ScheduleController scheduleController;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: scheduleController,
      child: Consumer<ScheduleController>(
          builder: (context, scheduleController, _) {
        return ScheduleVisualElement(
          state: scheduleController.scheduleState,
        );
      }),
    );
    // return ScheduleVisualElement(state: scheduleController.scheduleState);
  }
}

class ScheduleVisualElement extends StatelessWidget {
  const ScheduleVisualElement({Key? key, required this.state})
      : super(key: key);

  final ScheduleState state;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          if (state.isDone) LoadedSchedule(schedule: state.schedule),
          if (state.isLoading) Text("Loading..."),
          if (state.isError) Text("Error!"),
        ],
      ),
    );
  }
}

class LoadedSchedule extends StatefulWidget {
  const LoadedSchedule({Key? key, List<Event>? this.schedule})
      : super(key: key);

  final List<Event>? schedule;

  @override
  State<LoadedSchedule> createState() => _LoadedScheduleState();
}

class _LoadedScheduleState extends State<LoadedSchedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height - AppBar().preferredSize.height,
      child: Column(children: [
        Expanded(
          flex: 2,
          child: Text("<Name>'s Schedule"),
        ),
        Expanded(
          flex: 5,
          child: Callender(),
        ),
        Expanded(
          flex: 1,
          child: Text("Further Info"),
        )
      ]),
    );
  }
}

class Callender extends StatelessWidget {
  const Callender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: DayOfWeekRow(),
        ),
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          child: TimeOfDayColumn(),
        ),
      ],
    );
  }
}

class TimeOfDayColumn extends StatelessWidget {
  const TimeOfDayColumn({Key? key}) : super(key: key);

  static const List<String> _timesOfDay = [
    "",
    "6",
    "8",
    "10",
    "12",
    "2",
    "4",
    "6",
    "8"
  ];

  // static const List<String> _timesOfDay = [
  //   "",
  //   "6:00 AM",
  //   "7:00 AM",
  //   "8:00 AM",
  //   "9:00 AM",
  //   "10:00 AM",
  //   "11:00 AM",
  //   "12:00 AM",
  //   "1:00 PM",
  //   "2:00 PM",
  //   "3:00 PM",
  //   "4:00 PM",
  //   "5:00 PM",
  //   "6:00 PM",
  //   "7:00 PM",
  //   "8:00 PM"
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final String time in _timesOfDay) MajorEntry(label: time)
        ],
      ),
    );
  }
}

class DayOfWeekRow extends StatelessWidget {
  const DayOfWeekRow({
    Key? key,
  }) : super(key: key);

  static const List<String> _daysOfTheWeek = [
    "",
    "S",
    "M",
    "T",
    "W",
    "T",
    "F",
    "S"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 2.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (final String dow in _daysOfTheWeek) MajorEntry(label: dow)
        ],
      ),
    );
  }
}

class MajorEntry extends StatelessWidget {
  const MajorEntry({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.clip),
      ),
    );
  }
}

class MinorEntry extends StatelessWidget {
  const MinorEntry({
    Key? key,
    required this.label,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        label,
        style: TextStyle(fontSize: 16, overflow: TextOverflow.clip),
      ),
    );
  }
}
