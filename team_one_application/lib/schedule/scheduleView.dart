import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/schedule/scheduelState.dart';
import 'package:team_one_application/schedule/scheduleController.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:team_one_application/models/Event.dart';

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
  List<Event> events = <Event>[];

  FirebaseFirestore? _instance;

  void initState() {
    getDataFromFireStore().then((value) => null);
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
      Event meet = Event.fromJson(eventData);
      events.add(meet);
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
    //getDataFromFireStore().then((value) => null); //caused appointments to duplicate
    return Container(
      child: Column(
        children: [
          Text('ScheduleView ${widget.state.uId}'),
          // if (widget.state.isDone) Text(widget.state.schedule.toString()),
          // if (widget.state.isLoading) Text("Loading..."),
          // if (widget.state.isError) Text("Error!"),
          Container(
            child: SfCalendar(
              view: CalendarView.week,
              dataSource: MeetingDataSource(events),
              appointmentTextStyle:
                  const TextStyle(fontSize: 15, color: Colors.white),
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
  MeetingDataSource(List<Event> source) {
    appointments = getAppointments(source);
  }

  //convert event model to appointments for syncfusion calendar
  List<Appointment> getAppointments(List<Event> list) {
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

    for (int i = 0; i < list.length; i++) {
      final String name = list[i].name;
      DateTime startTime = list[i].startTime;
      DateTime endTime = list[i].endTime;

      meetings.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: name,
        color: colorCollection[i %
            8], //prevents index value from going out-of-bounds of colorCollection
      ));
    }
    return meetings;
  }
}
