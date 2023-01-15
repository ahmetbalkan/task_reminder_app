import 'package:isar/isar.dart';
part 'category.g.dart';

@collection
class CategoryModel {
  Id id = Isar.autoIncrement;
  bool categoryName;
  int categoryColor;

  CategoryModel(this.categoryName, this.categoryColor);
}
