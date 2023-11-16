/*
class AddCategoryModel {
  Data? data;
  String? message;
  bool? success;

  AddCategoryModel({this.data, this.message, this.success});

  AddCategoryModel.fromJson(Map<String, dynamic> json) {
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
  String? categoryName;
  String? categoryImage;

  Data({this.id, this.categoryName, this.categoryImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['CategoryName'];
    categoryImage = json['CategoryImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['CategoryName'] = this.categoryName;
    data['CategoryImage'] = this.categoryImage;
    return data;
  }
}*/
class AddCategoryModel {
  int id;
  String categoryName;
  String categoryImage;

  AddCategoryModel(
      {required this.id,
      required this.categoryName,
      required this.categoryImage});

  factory AddCategoryModel.fromJson(Map<String, dynamic> json) {
    return AddCategoryModel(
        id: json['id'],
        categoryName: json['CategoryName'],
        categoryImage: json['CategoryImage']);
  }
}
