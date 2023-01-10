part of 'intropage_bloc.dart';

abstract class IntroPageEvent extends Equatable {
  const IntroPageEvent();

  @override
  List<Object> get props => [];
}

class SetIntroCountEvent extends IntroPageEvent {
  final double setCount;
  const SetIntroCountEvent({required this.setCount});

  @override
  List<Object> get props => [setCount];
}
