import 'package:isar/isar.dart';
part 'user.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;
  bool isLogin;
  bool isPremium;
  String userName;
  String userkey;

  UserModel(this.isLogin, this.userName, this.userkey, this.isPremium);
}
