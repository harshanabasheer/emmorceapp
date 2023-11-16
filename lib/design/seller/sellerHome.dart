import 'dart:convert';
import 'package:emmorceapp/design/admin/viewOrder.dart';
import 'package:emmorceapp/design/seller/manageProduct.dart';
import 'package:flutter/material.dart';
import 'package:emmorceapp/model/gridModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../constants/constants.dart';



class SellerHome extends StatefulWidget {
  const SellerHome({super.key});

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  List items = [
    GridItems(img: 'images/manageproduct.jpeg', name: 'Manage Product'),
    GridItems(img: 'images/vieworder.jpeg', name: 'View Order'),
    GridItems(img: 'images/payment.png', name: 'Payment'),
  ];
  TextEditingController nameController = TextEditingController();
  String name = "";
  bool isLoding=true;

  @override
  void initState() {
    super.initState();
    _viewProfile();
  }

  Future<void> _viewProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int outid = (prefs.getInt('login_id') ?? 0);
    final url = Apiconstants.baseurl + Apiconstants.view_profile + outid.toString();
    var response = await http.get(Uri.parse(url));
    var body = json.decode(response.body);
    setState(() {
      name = body['data']['Name'];
      nameController.text = name;
      isLoding =false;

    });
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      final shouldPop = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Do you want to go back?'),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('No'),
              ),
            ],
          );
        },
      );
      return shouldPop!;
    },
    child:Scaffold(
      appBar: AppBar(
        title: Text(name),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 0.00,
        backgroundColor: Colors.blueAccent,
      ),
      // backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          clipBehavior: Clip.none,
          itemCount: items.length,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: ()  {
                switch (index) {
                  case 0:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ManageProduct()));
                    break;
                  case 1:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewOrderPage()));
                    break;
                  // case 2:
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewUsersPage()));
                  //   break;
                  // case 3:
                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => ViewOrderPage()));
                  //   break;

                }
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(items[index].img),
                      radius: 40,
                    ),
                    SizedBox(height: 10,),
                    Text(items[index].name, style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    )
    );
  }
}
