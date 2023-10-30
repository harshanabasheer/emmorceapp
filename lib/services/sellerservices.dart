import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:emmorceapp/design/login.dart';

import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/services/authdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:emmorceapp/model/sellermodel.dart';

Future<SellerModel>registerSeller({required BuildContext context,
  required String name,required String address,required String dateofbirth,
  required String phone,required String email,required String password})async{
  var data={
    "Name":name,
    "Address":address,
    "Dateofbirth":dateofbirth,
    "Phone":phone,
    "Email":email,
    "Password":password,
  };
  print('data $data');
  try{
    var response = await ApiServices().postdata(data,Apiconstants.seller_reg);
    var body = json.decode(response.body);
    print(body);
    if(body["success"]==true){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      return SellerModel.fromJson(jsonDecode(response.body));
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(body["message"])));
    }
  }
  catch(e){
    throw e.toString();
  }
  throw 'Unexpected error occured';

}