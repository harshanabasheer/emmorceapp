import 'package:flutter/material.dart';
import 'package:emmorceapp/design/user/userHome.dart';
import 'package:emmorceapp/services/loginService.dart';



class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _usernameController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  bool isLoading=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
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
                  child:TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.black),
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
                        borderSide: BorderSide(width: 2, color: Colors.black),
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
                child: ElevatedButton(onPressed: () async{
                 try{
                   isLoading=false;
                   setState(() {
                   });
                   await Api().login(context: context, username: _usernameController.text, password: _passwordController.text);
                   isLoading=true;
                   setState(() {
                   });
                 }catch(e){
                   isLoading=true;
                   setState(() {

                   });
                   print("error");
                 }

                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlueAccent,minimumSize: const Size.fromHeight(50), //
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),

                    ),
                  ),
                  child:isLoading==false?Center(child: CircularProgressIndicator(),): const Text('Login', style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),


            ],
          ),
        ),
      ),

    );
  }
}
