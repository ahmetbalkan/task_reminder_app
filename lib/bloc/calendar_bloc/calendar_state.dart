part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object> get props => [];
}

class CalendarInitial extends CalendarState {}

class AppointmentTaskState extends CalendarState {
  final List<Appointment> appointmentList;

  AppointmentTaskState({required this.appointmentList});
}
