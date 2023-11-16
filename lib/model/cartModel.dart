class CartItems {
  List<Data>? data;
  String? message;
  bool? success;

  CartItems({this.data, this.message, this.success});

  CartItems.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? productId;
  String? userName;
  String? productName;
  String? productImage;
  String? price;

  Data(
      {this.id,
        this.userId,
        this.productId,
        this.userName,
        this.productName,
        this.productImage,
        this.price});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    productId = json['ProductId'];
    userName = json['UserName'];
    productName = json['ProductName'];
    productImage = json['ProductImage'];
    price = json['Price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['ProductId'] = this.productId;
    data['UserName'] = this.userName;
    data['ProductName'] = this.productName;
    data['ProductImage'] = this.productImage;
    data['Price'] = this.price;
    return data;
  }
}