part of 'category_bloc.dart';

abstract class CategoryBlocEvent extends Equatable {
  const CategoryBlocEvent();

  @override
  List<Object> get props => [];
}

class AddCategoryEvent extends CategoryBlocEvent {
  final CategoryModel categoryModel;
  const AddCategoryEvent({required this.categoryModel});
}

class DeleteCategoryEvent extends CategoryBlocEvent {
  final int id;
  const DeleteCategoryEvent(this.id);
}

class GetCategoryEvent extends CategoryBlocEvent {}
