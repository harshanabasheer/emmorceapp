import 'package:flutter/material.dart';
import 'package:emmorceapp/services/sellerServices.dart';



class SellerSignUp extends StatefulWidget {
  const SellerSignUp({super.key});

  @override
  State<SellerSignUp> createState() => _SellerSignUpState();
}

class _SellerSignUpState extends State<SellerSignUp> {
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }
  TextEditingController _nameController=TextEditingController();
  TextEditingController _addressController=TextEditingController();
  TextEditingController _phoneController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  final _formKey =GlobalKey<FormState>();

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
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key:_formKey ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100,),
                  Padding(
                      padding: const EdgeInsets.only(left:40.0,right: 40),
                      child: // Note: Same code is applied for the TextFormField as well
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: "Name",
                        ),
                      )
                  ),
                  SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.only(left:40.0,right: 40),
                      child: // Note: Same code is applied for the TextFormField as well
                      TextFormField(
                        controller: _addressController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Address is required';
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: "Address",
                        ),
                      )
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40),
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextFormField(
                          controller: _dateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Date is required';
                            }
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: Colors.black),
                            ),
                            hintText: "Date of birth",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.only(left:40.0,right: 40),
                      child: // Note: Same code is applied for the TextFormField as well
                      TextFormField(
                        controller: _phoneController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Phone is required';
                          }
                          RegExp number=new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                          if(number.hasMatch(value)){
                            return null;
                          }else{
                            return 'Invalid Mobile number';
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: "Phone",
                        ),
                      )
                  ),
                  SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.only(left:40.0,right: 40),
                      child: // Note: Same code is applied for the TextFormField as well
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1, color: Colors.black),
                          ),
                          hintText: "Email",
                          // prefixIcon: Icon(Icons.email_outlined),

                        ),
                      )
                  ),
                  SizedBox(height: 10,),
                  Padding(
                      padding: const EdgeInsets.only(left:40.0,right: 40),
                      child: // Note: Same code is applied for the TextFormField as well
                      TextFormField(
                        controller: _passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                        },
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
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left:40.0,right: 40),
                    child: ElevatedButton(onPressed: (){
                      registerSeller(context: context, name: _nameController.text, address: _addressController.text,
                          dateofbirth: _dateController.text, phone: _phoneController.text,
                          email: _emailController.text, password: _passwordController.text);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.lightBlueAccent,minimumSize: const Size.fromHeight(50), //
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('SignUp', style: TextStyle(fontSize: 15,color: Colors.white),),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}
