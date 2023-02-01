import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:task_reminder_app/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:task_reminder_app/tools/extention.dart';

import '../../bloc/test_bloc/test_bloc.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

bool _switchValue = false;

class _CalendarPageState extends State<CalendarPage> {
  @override
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    context.read<CalendarBloc>().add(GetAppointmentEvent());
    return Theme(
        data: ThemeData.dark(),
        child: Container(
            color: context.backgroundColor,
            child: BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                if (state is AppointmentTaskState) {
                  return SfCalendar(
                    appointmentTextStyle: context.fontStyleLatoFontWeigt(
                        Colors.black54, 16, FontWeight.bold),
                    scheduleViewSettings: const ScheduleViewSettings(
                        monthHeaderSettings: MonthHeaderSettings(
                            monthFormat: 'MMMM, yyyy',
                            height: 50,
                            textAlign: TextAlign.left,
                            monthTextStyle:
                                TextStyle(fontWeight: FontWeight.w400))),
                    showDatePickerButton: false,
                    scheduleViewMonthHeaderBuilder: scheduleViewBuilder,
                    view: CalendarView.schedule,
                    allowAppointmentResize: true,
                    timeSlotViewSettings: TimeSlotViewSettings(
                      allDayPanelColor: Colors.red,
                      timeIntervalHeight: 100,
                    ),
                    monthViewSettings: MonthViewSettings(
                        showAgenda: true,
                        showTrailingAndLeadingDates: false,
                        appointmentDisplayMode:
                            MonthAppointmentDisplayMode.appointment),
                    dataSource: _DataSource(state.appointmentList),
                  );
                } else {
                  return Center();
                }
              },
            )));
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<Appointment> source) {
    appointments = source;
  }
}

Widget scheduleViewBuilder(
    BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
  final String monthName = _getMonthDate(details.date.month);
  return Stack(
    children: <Widget>[
      Positioned(
        left: 55,
        right: 0,
        top: 20,
        bottom: 0,
        child: Text(
          monthName + ' ' + details.date.year.toString(),
          style: const TextStyle(fontSize: 18),
        ),
      )
    ],
  );
}

String _getMonthDate(int month) {
  if (month == 01) {
    return 'January';
  } else if (month == 02) {
    return 'February';
  } else if (month == 03) {
    return 'March';
  } else if (month == 04) {
    return 'April';
  } else if (month == 05) {
    return 'May';
  } else if (month == 06) {
    return 'June';
  } else if (month == 07) {
    return 'July';
  } else if (month == 08) {
    return 'August';
  } else if (month == 09) {
    return 'September';
  } else if (month == 10) {
    return 'October';
  } else if (month == 11) {
    return 'November';
  } else {
    return 'December';
  }
}
