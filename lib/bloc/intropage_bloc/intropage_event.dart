part of 'intropage_bloc.dart';

abstract class IntropageEvent extends Equatable {
  const IntropageEvent();

  @override
  List<Object> get props => [];
}

class SetIntroCountEvent extends IntropageEvent {
  final double setCount;
  const SetIntroCountEvent({required this.setCount});

  @override
  List<Object> get props => [setCount];
}
