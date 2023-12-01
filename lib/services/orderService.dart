import 'dart:convert';
import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/bottombar.dart';
import 'package:emmorceapp/model/cartModel.dart';
import 'package:emmorceapp/model/orderModelCart.dart';
import 'package:emmorceapp/model/orderModelSingle.dart';
import 'package:emmorceapp/services/authdata.dart';

class OrderList{
  Future<dynamic> totalCartPrice(int userId) async {
    var response = await ApiServices()
        .getdata(Apiconstants.total_price + userId.toString());
    if (response.statusCode == 201) {
      var body = json.decode(response.body);
      return body;
    } else {
      throw Exception('failed to load');
    }
  }
  Future<OrderModelCart> orderCartProduct(int userId) async {
    var data= {
      "UserId": userId.toString(),
    };
    var response = await ApiServices().postdata(data,Apiconstants.order_cart_products);
    var body = json.decode(response.body);
    // print(body);
    if(body["success"]==true){
      cartLengthNotify.value  = 0;
      var body = json.decode(response.body);
      OrderModelCart _data = OrderModelCart.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }
  Future<CartItems> removeAllCartItems(int userId) async {
    var response = await ApiServices()
        .deletedata(Apiconstants.delete_all_cart + userId.toString());
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      CartItems _data = CartItems.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }

  Future<OrderModelSingle> orderSingleProduct(int userId,int productId) async {
    var data= {
      "UserId": userId.toString(),
      "ProductId": productId.toString(),
    };
    var response = await ApiServices().postdata(data,Apiconstants.order_single_product);
    var body = json.decode(response.body);
    if(body["success"]==true){
      cartLengthNotify.value  = 0;
      var body = json.decode(response.body);
      OrderModelSingle _data = OrderModelSingle.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }
  Future<OrderModelCart> getAllOrders() async {
    var response = await ApiServices().getdata(Apiconstants.all_orders);
    var body = json.decode(response.body);
    if (body["success"] == true) {
      var body = json.decode(response.body);
      OrderModelCart _data = OrderModelCart.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }


}
