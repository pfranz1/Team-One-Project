import 'dart:math';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/schedule/scheduelState.dart';
import 'package:team_one_application/schedule/scheduleController.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';

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

class ScheduleVisualElement extends StatefulWidget {
  const ScheduleVisualElement({Key? key, required this.state})
      : super(key: key);

  final ScheduleState state;

  @override
  _ScheduleVisualElementState createState() => _ScheduleVisualElementState();
}

class _ScheduleVisualElementState extends State<ScheduleVisualElement> {
  List<Meeting> _events = <Meeting>[];

  FirebaseFirestore? _instance;

  void initState() {
    // getDataFromFireStore().then((results) {
    //   SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
    //     setState(() {});
    //   });
    // });
    super.initState();
  }

  Future<void> getDataFromFireStore() async {
    _instance = FirebaseFirestore.instance;

    CollectionReference calendarCollection =
        _instance!.collection("CalendarCollection");

    DocumentSnapshot snapshot = await calendarCollection.doc('1').get();
    var data = snapshot.data() as Map;
    var eventsData = data['events'] as List<dynamic>;

    eventsData.forEach((eventData) {
      Meeting meet = Meeting.fromJson(eventData);
      _events.add(meet);
    });
  }

  Future uploadTestData() async {
    final docEvent =
        FirebaseFirestore.instance.collection('CalendarCollection').doc("1");

    final json = {
      'Subject': "Mastering Flutter",
      'StartTime': '22 March 2022 at 08:00:00',
      'EndTime': '22 March 2022 at 09:00:00'
    };

    await docEvent.set(json);
  }

  @override
  Widget build(BuildContext context) {
    getDataFromFireStore().then((value) => null);
    return Container(
      child: Column(
        children: [
          Text('ScheduleView ${widget.state.uId}'),
          if (widget.state.isDone) Text(widget.state.schedule.toString()),
          if (widget.state.isLoading) Text("Loading..."),
          if (widget.state.isError) Text("Error!"),
          IconButton(onPressed: () => uploadTestData(), icon: Icon(Icons.add)),
          Container(
            child: SfCalendar(
              view: CalendarView.week,
              dataSource: MeetingDataSource(_events),
            ),
            width: MediaQuery.of(context).size.width * .70,
            height: MediaQuery.of(context).size.height * .80,
          ),
        ],
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = getAppointments(source);
  }

  List<Appointment> getAppointments(List<Meeting> list) {
    List<Appointment> meetings = <Appointment>[];
    List<Color> colorCollection = <Color>[];
    colorCollection.add(Colors.black);
    colorCollection.add(Colors.blue);
    colorCollection.add(Colors.red);
    colorCollection.add(Colors.orange);
    colorCollection.add(Colors.purple);
    colorCollection.add(Colors.green);
    colorCollection.add(Colors.grey);
    colorCollection.add(Colors.brown);
    colorCollection.add(Colors.yellow);
    colorCollection.add(Colors.white);

    for (int i = 0; i < list.length; i++) {
      final String name = list[i].eventName;
      final DateTime today = DateTime.now();
      final DateTime startTime =
          DateTime(today.year, today.month, today.day, 9 + 3 * i, 0, 0);
      final DateTime endTime = startTime.add(const Duration(hours: 2));

      meetings.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: name,
          color: colorCollection[i],
          recurrenceRule: 
          );
    }

    return meetings;
  }
}

class Meeting {
  String eventName;
  DateTime from;
  DateTime to;
  Color? background;
  bool? isAllDay;

  Meeting(
      {required this.eventName,
      required this.from,
      required this.to,
      this.background,
      this.isAllDay});

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
        eventName: json['Subject'], from: DateTime.now(), to: DateTime.now());
  }
}
