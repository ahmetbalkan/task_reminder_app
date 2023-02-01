part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class PremiumCheckEvent extends GroupEvent {
  const PremiumCheckEvent();
}
