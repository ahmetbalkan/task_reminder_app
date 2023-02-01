part of 'group_bloc.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class PremiumCheckState extends GroupState {
  bool isPremium;
  String groupID;
  List<UserModel> userList;
  List<TaskModel> taskList;
  PremiumCheckState({
    required this.userList,
    required this.isPremium,
    required this.groupID,
    required this.taskList,
  });
}

class GetGroupUserState extends GroupState {
  List<UserModel> userList;
  GetGroupUserState({required this.userList});
}

class GetGroupTaskState extends GroupState {
  List<TaskModel> groupTask;
  GetGroupTaskState({required this.groupTask});
}
