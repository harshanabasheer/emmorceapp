import 'dart:convert';
import 'package:emmorceapp/design/user/homepage.dart';
import 'package:flutter/material.dart';

import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/services/authdata.dart';
import 'package:flutter/cupertino.dart';
import 'package:emmorceapp/model/loginmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api{
  late SharedPreferences localStorage;
  String role="";
  String user="user";
  String admin="admin";
  String seller="seller";


Future<LoginModel>login({required BuildContext context,
  required String username,required String password})async{
  var data={
    "UserName":username,
    "Password":password,

  };
  print('data $data');
  try{
    var response = await ApiServices().postdata(data,Apiconstants.login);
    var body = json.decode(response.body);
    print("response$body");
    if(body["success"]==true){
      role= body['data']['Role'];
      print(role);
      localStorage=await SharedPreferences.getInstance();
      localStorage.setString('role', role.toString());
      localStorage.setString('username', body['data']['UserName']);
      localStorage.setString('password', body['data']['Password']);
      localStorage.setInt('login_id', body['data']['login_id']);
      // print('login_id ${body['data']['login_id']}');

      if(role==user){
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }else if(role==admin){
      }else{
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