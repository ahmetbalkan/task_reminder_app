part of 'category_bloc.dart';

enum CategoryStatus { loading, success, failure }

class CategoryBlocState extends Equatable {
  final List<CategoryModel> categories;

  const CategoryBlocState({
    this.categories = const [],
  });

  @override
  List<Object> get props => [categories];

  CategoryBlocState copyWith({
    List<CategoryModel>? categories,
  }) {
    return CategoryBlocState(
      categories: categories ?? this.categories,
    );
  }
}
