import 'package:flutter/material.dart';
import 'package:emmorceapp/design/login.dart';
import 'package:emmorceapp/design/signup.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,minimumSize: const Size.fromHeight(50), //
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:40.0,right: 40),
                child: TextButton(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Text("Don't have an account? SignUp", style: TextStyle(fontSize: 15,color: Colors.black))),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SignUp()));
                  },

                ),

              ),


            ],
          ),
        ),
      ),

    );
  }
}
