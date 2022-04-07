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

bool DEBUG = false;

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
      Event _eventFromAppointment = appointmentDetails.id as Event;

      String _nameText = _eventFromAppointment.name;
      String _dateText =
          DateFormat('MMMM dd, yyyy').format(details.date!).toString();
      String _startTimeText = DateFormat('hh:mm a')
          .format(_eventFromAppointment.startTime)
          .toString();
      String _endTimeText = DateFormat('hh:mm a')
          .format(_eventFromAppointment.endTime)
          .toString();
      String _timeDetails = '$_startTimeText - $_endTimeText';
      String? _location = _eventFromAppointment.location;
      String? _type = _eventFromAppointment.type;

      showDialog(
          barrierColor: Colors.white10,
          context: context,
          builder: (BuildContext context) {
            switch (_type) {
              case "Lecture":
                {
                  Lecture _lectureFromAppointment =
                      appointmentDetails.id as Lecture;
                  return lectureEventPopup(
                      _nameText,
                      _location,
                      _timeDetails,
                      _dateText,
                      _lectureFromAppointment.isOnline,
                      _lectureFromAppointment.professor);
                }

              case "Office Hour":
                {
                  OfficeHour _officeFromAppointment =
                      appointmentDetails.id as OfficeHour;
                  return officeHoursEventPopup(
                      _nameText,
                      _location,
                      _timeDetails,
                      _dateText,
                      _officeFromAppointment.isOnline,
                      _officeFromAppointment.professor);
                }

              case "Club Meeting":
                {
                  ClubMeeting _clubfromAppointment =
                      appointmentDetails.id as ClubMeeting;
                  return clubEventPopup(_nameText, _location, _timeDetails,
                      _dateText, _clubfromAppointment.acronym);
                }

              default:
                {
                  return genericEventPopup(
                      _nameText, _location, _timeDetails, _dateText);
                }
            }
          });
    }
  }

  Widget genericEventPopup(String _nameText, String? _location,
      String _timeDetails, String _dateText) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .80,
        left: MediaQuery.of(context).size.width * .20,
      ),
      title: Container(child: Text('$_nameText')),
      alignment: Alignment.bottomCenter,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (_location != null)
            Text(
              'at $_location',
              style: const TextStyle(fontSize: 16),
            ),
          Row(
            children: [
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
        ],
      ),
    );
  }

  Widget lectureEventPopup(
      String _nameText,
      String? _location,
      String _timeDetails,
      String _dateText,
      bool _isOnline,
      String _professor) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .77,
        left: MediaQuery.of(context).size.width * .20,
      ),
      title: Container(
          child:
              (_isOnline) ? Text('$_nameText (Online)') : Text('$_nameText')),
      alignment: Alignment.bottomCenter,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (_location != null)
            Text(
              'at $_location',
              style: const TextStyle(fontSize: 16),
            ),
          Text('with $_professor'),
          Row(
            children: [
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
        ],
      ),
    );
  }

  Widget officeHoursEventPopup(
      String _nameText,
      String? _location,
      String _timeDetails,
      String _dateText,
      bool _isOnline,
      String _professor) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .80,
        left: MediaQuery.of(context).size.width * .20,
      ),
      title: Container(
          child:
              (_isOnline) ? Text('$_nameText (Online)') : Text('$_nameText')),
      alignment: Alignment.bottomCenter,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (_location != null)
            Text(
              'at $_location',
              style: const TextStyle(fontSize: 16),
            ),
          Text('$_professor\'s Office Hours'),
          Row(
            children: [
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
        ],
      ),
    );
  }

  Widget clubEventPopup(String _nameText, String? _location,
      String _timeDetails, String _dateText, String? _acronym) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * .80,
        left: MediaQuery.of(context).size.width * .20,
      ),
      title: Container(child: Text('$_nameText $_acronym')),
      alignment: Alignment.bottomCenter,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (_location != null)
            Text(
              'at $_location',
              style: const TextStyle(fontSize: 16),
            ),
          Row(
            children: [
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
        ],
      ),
    );
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
        id: list[i],
        notes: eventType,
      ));
    }
    return appointments;
  }
}
