import 'package:flutter/material.dart';
import 'package:emmorceapp/design/user/userSignup.dart';
import 'package:emmorceapp/design/seller/sellerSignup.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration:BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpg"),fit: BoxFit.cover
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:40.0,right: 40),
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SellerSignUp()));
                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,minimumSize: const Size.fromHeight(50), //
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Seller SignUp', style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:40.0,right: 40),
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> UserSignUp()));
                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,minimumSize: const Size.fromHeight(50), //
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('User SignUp', style: TextStyle(fontSize: 15,color: Colors.black),),
                ),
              ),


            ],
          ),
        ),
      ),

    );
  }
}
