part of 'test_bloc.dart';

abstract class TestEvent extends Equatable {
  const TestEvent();

  @override
  List<Object> get props => [];
}

class GetAllTaskEvent extends TestEvent {}

class GetCompleteTaskEvent extends TestEvent {}

class GetTodayTaskEvent extends TestEvent {}

class GetSearchTaskEvent extends TestEvent {
  String seachValue;

  GetSearchTaskEvent({required this.seachValue});
}
