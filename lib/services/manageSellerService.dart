import 'dart:convert';
import 'package:emmorceapp/constants/constants.dart';
import 'package:flutter/material.dart';
import '../model/manageSellerModel.dart';
import 'authdata.dart';

class AllSeller{
  Future<ManageSeller> getAllSellers()async{
    var response = await ApiServices().getdata(Apiconstants.all_seller);
    if(response.statusCode ==200){
      var body=json.decode(response.body);
      ManageSeller _data=ManageSeller.fromJson(body);
      return _data;
    }else{
     throw Exception('failed to load');
    }

  }
  Future<ManageSeller> getAllSellersAccpted()async{
    var response = await ApiServices().getdata(Apiconstants.all_seller_accepted);
    if(response.statusCode ==200){
      var body=json.decode(response.body);
      ManageSeller _data=ManageSeller.fromJson(body);
      return _data;
    }else{
      throw Exception('failed to load');
    }

  }
  Future<ManageSeller> acceptSeller(int sellerId,{required BuildContext context,}) async {
    var response = await ApiServices().postdata_accept(Apiconstants.accept_Seller + sellerId.toString(),);
    if(response.statusCode ==200){
      var body=json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(body["message"])));
      ManageSeller _data=ManageSeller.fromJson(body);
      return _data;
    }else{
      throw Exception('failed to load');
    }
  }
  Future<ManageSeller> deleteSeller(int loginId)async{
    var response = await ApiServices().deletedata(Apiconstants.delete_register + loginId.toString());
    print('url${Apiconstants.delete_register + loginId.toString()}');
    if(response.statusCode ==200){
      var body=json.decode(response.body);
      ManageSeller _data=ManageSeller.fromJson(body);
      return _data;
    }else{
      throw Exception('failed to load');
    }

  }

}




