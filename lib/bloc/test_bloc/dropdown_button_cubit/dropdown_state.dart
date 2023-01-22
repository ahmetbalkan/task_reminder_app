part of 'dropdown_cubit.dart';

abstract class DropDownNameState extends Equatable {
  final String name;
  const DropDownNameState({required this.name});

  @override
  List<Object> get props => [name];
}

class DropDownNameCubitInitial extends DropDownNameState {
  final String value;
  DropDownNameCubitInitial({required this.value}) : super(name: value);

  @override
  List<Object> get props => [value];
}
