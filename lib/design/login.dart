import 'package:flutter/material.dart';
import 'package:emmorceapp/design/user/homepage.dart';
import 'package:emmorceapp/services/loginservice.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration:BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/background.jpeg"),fit: BoxFit.cover
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.yellow,
                backgroundImage: AssetImage('images/icon.jpeg'),
              ),

              SizedBox(height: 100,),
              Padding(
                  padding: const EdgeInsets.only(left:40.0,right: 40),
                  child:TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      hintText: "User Name",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                  )
              ),
              SizedBox(height: 20,),
              Padding(
                  padding: const EdgeInsets.only(left:40.0,right: 40),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                      ),
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password),
                    ),

                  )
              ),
              SizedBox(height: 20,),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:40.0,right: 40),
                child: ElevatedButton(onPressed: (){
                  Api().login(context: context, username: _usernameController.text, password: _passwordController.text);

                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,minimumSize: const Size.fromHeight(50), //
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),

                    ),
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 15,color: Colors.black),),
                ),
              ),


            ],
          ),
        ),
      ),

    );
  }
}
