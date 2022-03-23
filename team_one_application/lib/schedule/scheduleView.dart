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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('ScheduleView ${widget.state.uId}'),
          if (widget.state.isError)
            Container(
              child: const Text("Error!"),
            ),
          if (widget.state.isLoading)
            Text("Loading..."), //add loading animation
          if (widget.state.isDone)
            Container(
              child: SfCalendar(
                view: CalendarView.week,
                allowedViews: const [
                  CalendarView.week,
                  CalendarView.workWeek,
                  CalendarView.month
                ],
                timeSlotViewSettings:
                    const TimeSlotViewSettings(startHour: 3, endHour: 23),
                dataSource: MeetingDataSource(widget.state.schedule),
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
    List<Appointment> appointments = <Appointment>[];
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
      final String eventName = list[i].name;
      DateTime eventStartTime = list[i].startTime;
      DateTime eventEndTime = list[i].endTime;
      String? eventRecurrence = list[i].daysOfWeek;

      appointments.add(Appointment(
          startTime: eventStartTime,
          endTime: eventEndTime,
          subject: eventName,
          color: colorCollection[i %
              8], //prevents index value from going out-of-bounds of colorCollection
          recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=[$eventRecurrence]'));
    }
    return appointments;
  }
}
