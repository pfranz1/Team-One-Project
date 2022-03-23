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
  List<Color> _colorCollection = <Color>[];
  List<Meeting> events = <Meeting>[];
  final databaseReference = FirebaseFirestore.instance;

  void initState() {
    _initializeEventColor();
    // getDataFromFireStore().then((results) {
    //   SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
    //     setState(() {});
    //   });
    // });
    super.initState();
  }

  // Future<void> getDataFromFireStore() async {
  //   var snapShotsValue =
  //       await databaseReference.collection('CalendarCollection').get();

  //   final Random random = new Random();
  //   List<Meeting> list = snapShotsValue.docs
  //       .map((e) => Meeting(
  //             eventName: e.data()['Subject'],
  //             from: DateFormat('dd/MM/yyyy HH:mm:ss')
  //                 .parse(e.data()['StartTime']),
  //             to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['EndTime']),
  //             // background: _colorCollection[random.nextInt(9)],
  //             // isAllDay: false
  //           ))
  //       .toList();
  //   setState(() {
  //     events = list;
  //   });
  // }
  Stream<List<Meeting>> getDataFromFireStore() => FirebaseFirestore.instance
      .collection('CalendarCollection')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Meeting.fromJson(doc.data())).toList());

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

  // void uploadTestData() {
  //   databaseReference.collection("/CalendarCollection")
  //     ..doc("1").set({
  //       'Subject': "Mastering Flutter",
  //       'StartTime': '03/22/2022 08:00:00',
  //       'EndTime': '03/22/2022 09:00:00'
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Meeting>>(
        stream: getDataFromFireStore(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            events = snapshot.data!;

            return Container(
              child: Column(
                children: [
                  Text('ScheduleView ${widget.state.uId}'),
                  if (widget.state.isDone)
                    Text(widget.state.schedule.toString()),
                  if (widget.state.isLoading) Text("Loading..."),
                  if (widget.state.isError) Text("Error!"),
                  IconButton(
                      onPressed: () => uploadTestData(), icon: Icon(Icons.add)),
                  Container(
                    child: SfCalendar(
                      view: CalendarView.week,
                      dataSource: MeetingDataSource(events),
                    ),
                    width: MediaQuery.of(context).size.width * .70,
                    height: MediaQuery.of(context).size.height * .80,
                  ),
                ],
              ),
            );
          } else {
            return Container(
                child: Column(children: [
              Text('ScheduleView ${widget.state.uId}'),
              if (widget.state.isDone) Text(widget.state.schedule.toString()),
              if (widget.state.isLoading) Text("Loading..."),
              if (widget.state.isError) Text("Error!"),
              IconButton(
                  onPressed: () => uploadTestData(), icon: Icon(Icons.add)),
            ]));
          }
        });
  }

  void _initializeEventColor() {
    _colorCollection.add(Colors.black);
    _colorCollection.add(Colors.blue);
    _colorCollection.add(Colors.red);
    _colorCollection.add(Colors.orange);
    _colorCollection.add(Colors.purple);
    _colorCollection.add(Colors.green);
    _colorCollection.add(Colors.grey);
    _colorCollection.add(Colors.brown);
    _colorCollection.add(Colors.yellow);
    _colorCollection.add(Colors.white);
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = getAppointments(source);
  }

  List<Appointment> getAppointments(List<Meeting> list) {
    List<Appointment> meetings = <Appointment>[];
    // final DateTime today = DateTime.now();
    // final DateTime startTime =
    //     DateTime(today.year, today.month, today.day, 9, 0, 0);
    // final DateTime endTime = startTime.add(const Duration(hours: 2));

    // meetings.add(Appointment(
    //     startTime: startTime,
    //     endTime: endTime,
    //     subject: "Conference",
    //     color: Colors.blue));

    for (int i = 0; i < list.length - 1; i++) {
      final String name = list[i].eventName;
      final DateTime startTime = list[i].from;
      final DateTime endTime = list[i].to;

      meetings.add(Appointment(
          startTime: startTime,
          endTime: endTime,
          subject: name,
          color: Colors.blue));
    }

    return meetings;
  }

  // @override
  // DateTime getStartTime(int index) {
  //   return appointments![index].from;
  // }

  // @override
  // DateTime getEndTime(int index) {
  //   return appointments![index].to;
  // }

  // @override
  // bool isAllDay(int index) {
  //   return appointments![index].isAllDay;
  // }

  // @override
  // String getSubject(int index) {
  //   return appointments![index].eventName;
  // }

  // @override
  // Color getColor(int index) {
  //   return appointments![index].background;
  // }
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

  static Meeting fromJson(Map<String, dynamic> json) => Meeting(
      eventName: json['Subject'],
      from: (json['StartTime'] as Timestamp).toDate(),
      to: (json['EndTime'] as Timestamp).toDate());
}
