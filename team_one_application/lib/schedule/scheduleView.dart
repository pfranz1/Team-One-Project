import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:team_one_application/schedule/scheduelState.dart';
import 'package:team_one_application/schedule/scheduleController.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:team_one_application/models/Event.dart';
import 'package:intl/intl.dart';

bool DEBUG = true;

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
        return Column(
          children: [
            if (DEBUG) ...[
              Text('ScheduleView ${scheduleController.scheduleState.uId}'),
              ElevatedButton(
                  onPressed: () => scheduleController.uploadEventData(),
                  child: Text("Upload Events")),
              ElevatedButton(
                  onPressed: () => scheduleController.uploadFriendData(),
                  child: Text("Upload Friends")),
            ],
            ScheduleVisualElement(
              state: scheduleController.scheduleState,
            ),
          ],
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
  //details is the collection of appointments that return from the selected date
  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment) {
      final Appointment appointmentDetails = details.appointments![0];
      String _subjectText = appointmentDetails.subject;
      String _dateText =
          DateFormat('MMMM dd, yyyy').format(details.date!).toString();
      String _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      String _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      String _timeDetails = '$_startTimeText - $_endTimeText';

      showDialog(
          barrierColor: Colors.white10,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              insetPadding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * .75,
                left: MediaQuery.of(context).size.width * .20,
              ),
              title: Container(child: Text('$_subjectText')),
              alignment: Alignment.bottomCenter,
              content: Row(
                children: <Widget>[
                  Text(
                    '$_dateText  ($_timeDetails)',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'))
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          if (widget.state.isError)
            Container(
              child: const Text("Error!"),
            ),
          if (widget.state.isLoading)
            Container(
              width: MediaQuery.of(context).size.width * .70,
              height: MediaQuery.of(context).size.height * .80,
              child: const Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
              ),
            ),
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
                onTap: calendarTapped,
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
      String? eventType = list[i].type;

      appointments.add(Appointment(
        startTime: eventStartTime,
        endTime: eventEndTime,
        subject: eventName,
        color: colorCollection[i %
            8], //prevents index value from going out-of-bounds of colorCollection
        recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=[$eventRecurrence]',
      ));
    }
    return appointments;
  }
}
