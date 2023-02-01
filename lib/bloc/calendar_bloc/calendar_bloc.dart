import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../locator.dart';
import '../../repository/task_isar_repository.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarInitial()) {
    on<GetAppointmentEvent>(_getAppointment);
    on<GetAppointmentUpdateEvent>(_getAppointmentUpdate);
  }

  var _taskIsarRepository = locator.get<TaskIsarRepository>();
  _getAppointment(GetAppointmentEvent event, Emitter<CalendarState> emit) {
    emit(CalendarInitial());
    final List<Appointment> appointments = <Appointment>[];
    _taskIsarRepository.listenFullTask().listen((taskModel) {
      var a = taskModel.map((e) {
        return Appointment(
          notes: e.desc,
          subject: e.title!,
          id: e.id,
          startTime: e.startDate!,
          endTime: e.EndDate!,
          color: Color(e.categoryColor!).withOpacity(0.5),
        );
      }).toList();
      add(GetAppointmentUpdateEvent(appointmentList: a));
    });
  }

  _getAppointmentUpdate(
      GetAppointmentUpdateEvent event, Emitter<CalendarState> emit) {
    emit(AppointmentTaskState(appointmentList: event.appointmentList));
  }
}
