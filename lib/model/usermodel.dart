class UserModel {
  Data? data;
  String? message;
  bool? success;

  UserModel({this.data, this.message, this.success});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? address;
  String? dateofbirth;
  String? email;
  String? phone;
  String? userName;
  String? password;
  String? role;
  int? login;

  Data(
      {this.id,
        this.name,
        this.address,
        this.dateofbirth,
        this.email,
        this.phone,
        this.userName,
        this.password,
        this.role,
        this.login});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    address = json['Address'];
    dateofbirth = json['Dateofbirth'];
    email = json['Email'];
    phone = json['Phone'];
    userName = json['UserName'];
    password = json['Password'];
    role = json['Role'];
    login = json['Login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['Address'] = this.address;
    data['Dateofbirth'] = this.dateofbirth;
    data['Email'] = this.email;
    data['Phone'] = this.phone;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['Role'] = this.role;
    data['Login'] = this.login;
    return data;
  }
}