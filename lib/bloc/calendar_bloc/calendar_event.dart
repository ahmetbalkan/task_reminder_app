part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class GetAppointmentEvent extends CalendarEvent {
  const GetAppointmentEvent();
}

class GetAppointmentUpdateEvent extends CalendarEvent {
  final List<Appointment> appointmentList;
  const GetAppointmentUpdateEvent({required this.appointmentList});
}
