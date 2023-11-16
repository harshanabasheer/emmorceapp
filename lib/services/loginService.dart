import 'dart:convert';
import 'package:emmorceapp/design/seller/sellerHome.dart';
import 'package:emmorceapp/design/user/userHome.dart';
import 'package:flutter/material.dart';

import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/services/authdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:emmorceapp/model/loginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../design/admin/adminHome.dart';

class Api{
  late SharedPreferences localStorage;
  String role="";
  String status='1';
  String user="user";
  String admin="admin";
  String seller="seller";


Future<LoginModel>login({required BuildContext context,
  required String username,required String password})async{
  var data={
    "UserName":username,
    "Password":password,

  };
  try{
    var response = await ApiServices().postdata(data,Apiconstants.login);
    var body = json.decode(response.body);
    if(body["success"]==true){
      role= body['data']['Role'];
      status=body['data']['Status'];
      print("role=${role}");
      print("status=${status}");
      localStorage=await SharedPreferences.getInstance();
      localStorage.setString('role', role.toString());
      localStorage.setString('username', body['data']['UserName']);
      localStorage.setString('password', body['data']['Password']);
      localStorage.setInt('login_id', body['data']['login_id']);
      localStorage.setInt('userid', body['data']['userid']);

      if(role==user){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      }else if(role==seller && status == "1"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SellerHome()));
      }else if(role==admin){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHome()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Please Wait for Admin Approval")));
      }
      return LoginModel.fromJson(jsonDecode(response.body));
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
}