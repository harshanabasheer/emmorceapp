class PaymentModel {
  Data? data;
  String? message;
  bool? success;

  PaymentModel({this.data, this.message, this.success});

  PaymentModel.fromJson(Map<String, dynamic> json) {
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
  String? totalAmount;
  String? paymentMethod;
  String? paymentStatus;
  String? address;

  Data(
      {this.id,
        this.userId,
        this.totalAmount,
        this.paymentMethod,
        this.paymentStatus,
        this.address});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    totalAmount = json['TotalAmount'];
    paymentMethod = json['PaymentMethod'];
    paymentStatus = json['PaymentStatus'];
    address = json['Address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['TotalAmount'] = this.totalAmount;
    data['PaymentMethod'] = this.paymentMethod;
    data['PaymentStatus'] = this.paymentStatus;
    data['Address'] = this.address;
    return data;
  }
}