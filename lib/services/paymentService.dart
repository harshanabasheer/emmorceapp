import 'dart:convert';
import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/bottombar.dart';
import 'package:emmorceapp/model/orderModelCart.dart';
import 'package:emmorceapp/model/orderModelSingle.dart';
import 'package:emmorceapp/model/paymentModel.dart';
import 'package:emmorceapp/services/authdata.dart';
import 'package:flutter/material.dart';

class PaymentService{
  Future<PaymentModel> payment({required BuildContext context,
    required String paymentMethod,required String address, required int userId}) async {
    var data= {
      "UserId": userId.toString(),
      "PaymentMethod":paymentMethod,
      "Address":address,
    };
    print(data);
    var response = await ApiServices().postdata(data,Apiconstants.payment_function);
    var body = json.decode(response.body);

    print("hye $body");
    if(body["success"]==true){
      var body = json.decode(response.body);
      PaymentModel _data = PaymentModel.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }
  Future<dynamic> totalAmount(int id) async {
    var response = await ApiServices()
        .getdata(Apiconstants.total_amount_payment + id.toString());
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      return body;
    } else {
      throw Exception('failed to load');
    }
  }

}
