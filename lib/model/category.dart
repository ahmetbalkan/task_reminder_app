import 'package:isar/isar.dart';
part 'category.g.dart';

@collection
class CategoryModel {
  Id id = Isar.autoIncrement;
  String categoryName;
  int categoryColor;
  int icon;

  CategoryModel(this.categoryName, this.categoryColor, this.icon);
}
