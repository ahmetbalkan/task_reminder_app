part of 'intropage_bloc.dart';

abstract class IntroPageState extends Equatable {
  final double getCount;
  const IntroPageState({required this.getCount});

  @override
  List<Object> get props => [getCount];
}

class IntropageInitial extends IntroPageState {
  final double ilkdeger;

  const IntropageInitial({required this.ilkdeger}) : super(getCount: ilkdeger);
}
