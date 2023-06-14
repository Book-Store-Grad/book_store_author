class LoginModel {
  String? accessToken;
  Content? content;

  LoginModel({this.accessToken, this.content});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
  }
}

class Content {
  User? user;

  Content({this.user});

  Content.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
  int? uId;
  String? uName;
  String? uEmail;
  String? uGender;
  String? uRole;

  User({this.uId, this.uName, this.uEmail, this.uGender, this.uRole});

  User.fromJson(Map<String, dynamic> json) {
    uId = json['u_id']??'';
    uName = json['u_name']??'';
    uEmail = json['u_email']??'';
    uGender = json['u_gender']??'';
    uRole = json['u_role'];
  }
}
