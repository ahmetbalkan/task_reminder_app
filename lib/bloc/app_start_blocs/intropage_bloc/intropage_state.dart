part of 'intropage_bloc.dart';

abstract class IntropageState extends Equatable {
  final double getCount;
  const IntropageState({required this.getCount});

  @override
  List<Object> get props => [getCount];
}

class IntropageInitial extends IntropageState {
  final double ilkdeger;

  const IntropageInitial({required this.ilkdeger}) : super(getCount: ilkdeger);
}
