class CategoryListModel {
  List<Data>? data;
  String? message;
  bool? success;

  CategoryListModel({this.data, this.message, this.success});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
}