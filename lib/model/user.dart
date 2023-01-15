import 'package:isar/isar.dart';
part 'user.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;
  bool isLogin;
  bool userName;
  int userColor;

  UserModel(this.isLogin, this.userName, this.userColor);
}
