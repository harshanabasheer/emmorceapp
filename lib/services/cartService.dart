import 'dart:convert';
import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/model/cartModel.dart';
import 'authdata.dart';

class CartList {
  Future<CartItems> getAllCart() async {
    var response = await ApiServices().getdata(Apiconstants.cart_list);
    var body = json.decode(response.body);
    // print("body{$body}");
    if(body["success"]==true){
      var body = json.decode(response.body);
      CartItems _data = CartItems.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }

  Future<CartItems> removeFromCart(int productId) async {
    var response = await ApiServices()
        .deletedata(Apiconstants.delete_cart + productId.toString());
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      CartItems _data = CartItems.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }

}
