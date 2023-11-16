import 'dart:convert';
import 'package:emmorceapp/constants/constants.dart';
import '../model/viewUserModel.dart';
import 'authdata.dart';

class AllUser{
  Future<ViewUsers> getAllUsers()async{
    var response = await ApiServices().getdata(Apiconstants.all_user);
    if(response.statusCode ==200){
      var body=json.decode(response.body);
      ViewUsers _data=ViewUsers.fromJson(body);
      return _data;
    }else{
      throw Exception('failed to load');
    }

  }

}




