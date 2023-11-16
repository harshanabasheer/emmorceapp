class LoginModel {
  Data? data;
  bool? success;
  String? message;

  LoginModel({this.data, this.success, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? name;
  int? userid;
  int? loginId;
  String? userName;
  String? password;
  String? role;

  Data(
      {this.name,
        this.userid,
        this.loginId,
        this.userName,
        this.password,
        this.role});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    userid = json['userid'];
    loginId = json['login_id'];
    userName = json['UserName'];
    password = json['password'];
    role = json['Role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['userid'] = this.userid;
    data['login_id'] = this.loginId;
    data['UserName'] = this.userName;
    data['password'] = this.password;
    data['Role'] = this.role;
    return data;
  }
}