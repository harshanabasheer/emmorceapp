import 'dart:convert';

import 'package:emmorceapp/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:emmorceapp/design/user/listview.dart';
import 'package:emmorceapp/design/user/grid.dart';
import 'package:emmorceapp/design/bottombar.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void closeAppUsingSystemPop() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }
  // TextEditingController searchController = TextEditingController();
  // bool isSearching = false;
  // Future<void> searchData(String query) async {
  //   try {
  //     final response = await http.post(Uri.parse(Apiconstants.baseurl + Apiconstants.search_product ),
  //       body: {'query': query},
  //     );
  //     if (response.statusCode == 200) {
  //       Map<String, dynamic> responseData = json.decode(response.body);
  //       List<dynamic> data = responseData['data'];
  //       print(data);
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
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
                  closeAppUsingSystemPop();
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
        title: Text("E-COMMERCE"),
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
        actions:  [
          CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: IconButton(
                onPressed: () {
                  // searchData(searchController.text);
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )

          ),
        ],
    ),
      backgroundColor: Colors.white,
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: CircleList()),
            Expanded(
                flex: 6,
                child: Grid()),
          ],
        ),
      ),
      bottomNavigationBar:  BottomBar(),
    )
    );
  }
}
