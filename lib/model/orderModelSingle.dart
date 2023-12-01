class OrderModelSingle {
  Data? data;
  String? message;
  bool? success;

  OrderModelSingle({this.data, this.message, this.success});

  OrderModelSingle.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? userName;
  String? productId;
  String? productName;
  String? productImage;
  String? category;
  Null? cartId;
  String? totalAmount;
  String? orderStatus;

  Data(
      {this.id,
        this.userId,
        this.userName,
        this.productId,
        this.productName,
        this.productImage,
        this.category,
        this.cartId,
        this.totalAmount,
        this.orderStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    userName = json['UserName'];
    productId = json['ProductId'];
    productName = json['ProductName'];
    productImage = json['ProductImage'];
    category = json['Category'];
    cartId = json['CartId'];
    totalAmount = json['TotalAmount'];
    orderStatus = json['OrderStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['ProductId'] = this.productId;
    data['ProductName'] = this.productName;
    data['ProductImage'] = this.productImage;
    data['Category'] = this.category;
    data['CartId'] = this.cartId;
    data['TotalAmount'] = this.totalAmount;
    data['OrderStatus'] = this.orderStatus;
    return data;
  }
}