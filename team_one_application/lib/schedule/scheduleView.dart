import 'package:cloud_firestore/cloud_firestore.dart';
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
          height: MediaQuery.of(context).size.height -
              AppBar().preferredSize.height,
          width: MediaQuery.of(context).size.width * 0.7,
        );
      }),
    );
    // return ScheduleVisualElement(state: scheduleController.scheduleState);
  }
}

class ScheduleVisualElement extends StatelessWidget {
  const ScheduleVisualElement({
    Key? key,
    required this.state,
    required this.height,
    required this.width,
  }) : super(key: key);

  final ScheduleState state;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        children: [
          if (state.isDone)
            LoadedSchedule(
              schedule: state.schedule,
              height: height,
              width: width,
            ),
          if (state.isLoading) Text("Loading..."),
          if (state.isError) Text("Error!"),
        ],
      ),
    );
  }
}

class LoadedSchedule extends StatefulWidget {
  const LoadedSchedule(
      {Key? key,
      List<Event>? this.schedule,
      required this.height,
      required this.width})
      : super(key: key);

  final List<Event>? schedule;
  final double height;
  final double width;

  @override
  State<LoadedSchedule> createState() => _LoadedScheduleState();
}

class _LoadedScheduleState extends State<LoadedSchedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      child: Column(children: [
        const Expanded(
          flex: 1,
          child: Text("<Name>'s Schedule"),
        ),
        Callender(height: widget.height * 0.6, width: widget.width),
        const Expanded(
          flex: 2,
          child: Text("Further Info"),
        )
      ]),
    );
  }
}

class Callender extends StatelessWidget {
  const Callender({Key? key, required this.height, required this.width})
      : super(key: key);

  final double height;
  final double width;

  static const double dowHeight = 80; // Day of week bar height
  static const double todWidth = 80; // Time of day bar width

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: todWidth,
            child: DayOfWeekRow(
              height: dowHeight,
              width: width - todWidth,
            ),
          ),
          Positioned(
            top: dowHeight,
            left: 0,
            child: TimeOfDayColumn(
              height: height - dowHeight,
              width: todWidth,
            ),
          ),
        ],
      ),
    );
  }
}

class TimeOfDayColumn extends StatelessWidget {
  const TimeOfDayColumn({Key? key, required this.height, required this.width})
      : super(key: key);

  final double height;
  final double width;

  static const List<String> _timesOfDay = [
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
    return SizedBox(
      width: width,
      height: height,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final String time in _timesOfDay) MajorEntry(label: time)
          ],
        ),
      ),
    );
  }
}

class DayOfWeekRow extends StatelessWidget {
  const DayOfWeekRow({Key? key, required this.height, required this.width})
      : super(key: key);

  final double height;
  final double width;

  static const List<String> _daysOfTheWeek = [
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
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (final String dow in _daysOfTheWeek) MajorEntry(label: dow)
          ],
        ),
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.clip),
          ),
        ),
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
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          overflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
