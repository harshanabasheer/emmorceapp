class AddProduct {
  Data? data;
  String? message;
  bool? success;

  AddProduct({this.data, this.message, this.success});

  AddProduct.fromJson(Map<String, dynamic> json) {
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
  String? productName;
  String? price;
  String? category;
  String? color;
  String? productImage;
  String? description;

  Data(
      {this.id,
        this.productName,
        this.price,
        this.category,
        this.color,
        this.productImage,
        this.description});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['ProductName'];
    price = json['Price'];
    category = json['Category'];
    color = json['Color'];
    productImage = json['ProductImage'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ProductName'] = this.productName;
    data['Price'] = this.price;
    data['Category'] = this.category;
    data['Color'] = this.color;
    data['ProductImage'] = this.productImage;
    data['Description'] = this.description;
    return data;
  }
}