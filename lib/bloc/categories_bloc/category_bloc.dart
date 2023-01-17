import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_reminder_app/model/category.dart';
import '../../locator.dart';
import '../../repository/category_isar_repository.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryBlocEvent, CategoryBlocState> {
  var _categoryIsarRepository = locator.get<CategoryIsarRepository>();
  CategoryBloc() : super(CategoryBlocState()) {
    on<AddCategoryEvent>(_addCategory);
    on<DeleteCategoryEvent>(_deleteCategoryEvent);
  }

  _addCategory(AddCategoryEvent event, Emitter<CategoryBlocState> emit) {
    _categoryIsarRepository.saveCategory(event.categoryModel);
  }

  _deleteCategoryEvent(
      DeleteCategoryEvent event, Emitter<CategoryBlocState> emit) async {
    var data = await _categoryIsarRepository.getAllCategory();

    if (data.length > 1) {
      await _categoryIsarRepository.deleteCategory(event.id);
    }
  }
}
