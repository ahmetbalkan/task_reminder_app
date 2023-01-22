part of 'test_bloc.dart';

abstract class TestEvent extends Equatable {
  const TestEvent();

  @override
  List<Object> get props => [];
}

class DeleteTaskEvent extends TestEvent {
  final int id;
  const DeleteTaskEvent(this.id);
}

class AddTestEvent extends TestEvent {
  final TaskModel taskModel;

  const AddTestEvent({
    required this.taskModel,
  });
}

class EditTestEvent extends TestEvent {
  final TaskModel taskModel;
  final String dropDownValue;

  const EditTestEvent({
    required this.taskModel,
    required this.dropDownValue,
  });
}

class UpdateTestEvent extends TestEvent {
  final TaskModel taskModel;
  const UpdateTestEvent({required this.taskModel});
}

class AllTaskEvent extends TestEvent {
  final String dropDownValue;
  final String searchValue;
  const AllTaskEvent({required this.dropDownValue, required this.searchValue});
}

class AllTaskEventUpdateEvent extends TestEvent {
  final List<TaskModel> updatedlist;
  final String dropDownValue;

  const AllTaskEventUpdateEvent(
      {required this.updatedlist, required this.dropDownValue});
}

class CompleteTaskEvent extends TestEvent {
  final String dropDownValue;
  final String searchValue;
  const CompleteTaskEvent(
      {required this.dropDownValue, required this.searchValue});
}

class CompleteTaskUpdateEvent extends TestEvent {
  final List<TaskModel> updatedlist;
  final String dropDownValue;

  const CompleteTaskUpdateEvent(
      {required this.updatedlist, required this.dropDownValue});
}

class TodayTaskEvent extends TestEvent {
  final String dropDownValue;
  final String searchValue;
  const TodayTaskEvent(
      {required this.dropDownValue, required this.searchValue});
}

class TodayTaskUpdateEvent extends TestEvent {
  final List<TaskModel> updatedlist;
  final String dropDownValue;

  const TodayTaskUpdateEvent(
      {required this.updatedlist, required this.dropDownValue});
}

class SearchTaskEvent extends TestEvent {
  final String dropDownValue;
  final String searchValue;
  const SearchTaskEvent(
      {required this.dropDownValue, required this.searchValue});
}

class SearchTaskUpdateEvent extends TestEvent {
  final List<TaskModel> updatedlist;
  final String dropDownValue;

  const SearchTaskUpdateEvent(
      {required this.updatedlist, required this.dropDownValue});
}
