import 'dart:async';

import 'package:emmorceapp/design/seller/sellerHome.dart';
import 'package:emmorceapp/design/start.dart';
import 'package:emmorceapp/design/user/userHome.dart';
import 'package:flutter/material.dart';
import 'package:emmorceapp/design/login.dart';
import 'package:emmorceapp/design/signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin/adminHome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences localStorage;
  String role="";
  String user="user";
  String admin="admin";
  String seller="seller";
  Future<void>checkRoleAndNavigate()async{
    localStorage = await SharedPreferences.getInstance();
    role = (localStorage.getString("role")??'');

    if(role.isEmpty){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Welcome()));
    }else if(role == user){
      Navigator.pushReplacement(context,PageTransition(child: const HomePage(), type: PageTransitionType.bottomToTop));
    }else if(role == admin){
      Navigator.pushReplacement(context,PageTransition(child: const AdminHome(), type: PageTransitionType.bottomToTop));
    }else{
      Navigator.pushReplacement(context,PageTransition(child: const SellerHome(), type: PageTransitionType.bottomToTop));

    }
  }
  void initState(){
    super.initState();
    startTime();
  }
  startTime()async{
    var duration = new Duration(seconds: 2);
    return Timer(duration, checkRoleAndNavigate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration:BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpeg"),fit: BoxFit.cover
          ),
        ),
      ),

    );
  }
}
