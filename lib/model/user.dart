class UserModel {
  String? userid;
  String? namesurname;
  String? profilPic;
  bool? isLogin;
  bool? isIntroComplete;

  UserModel(this.userid, this.namesurname, this.profilPic, this.isLogin,
      this.isIntroComplete);

  get getUserid => this.userid;

  set setUserid(userid) => this.userid = userid;

  get getNamesurname => this.namesurname;

  set setNamesurname(namesurname) => this.namesurname = namesurname;

  get getProfilPic => this.profilPic;

  set setProfilPic(profilPic) => this.profilPic = profilPic;

  get getIsLogin => this.isLogin;

  set setIsLogin(isLogin) => this.isLogin = isLogin;

  get getIsIntroComplete => this.isIntroComplete;

  set setIsIntroComplete(isIntroComplete) =>
      this.isIntroComplete = isIntroComplete;
}
