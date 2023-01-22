import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dropdown_state.dart';

class DropDownNameCubit extends Cubit<DropDownNameState> {
  DropDownNameCubit() : super(DropDownNameCubitInitial(value: "Bu Gün"));

  setName(String value) {
    emit(DropDownNameCubitInitial(value: value));
  }
}
