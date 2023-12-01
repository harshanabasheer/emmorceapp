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
  ValueNotifier<String> searchNotifier = ValueNotifier<String>('');
  TextEditingController searchController = TextEditingController();
  bool isSearching=false;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      searchNotifier.value = searchController.text;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
        title: !isSearching
            ? Text('E-COMMERCE')
            : TextField(
          controller: searchController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            icon: Icon(Icons.search, color: Colors.white),
            hintText: "Search here...",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          isSearching
              ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                this.isSearching = false;
                searchController.clear();
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                this.isSearching = true;
              });
            },
          )
        ],
      ),
      body:  Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: CircleList()),
            Expanded(
                flex: 6,
                child: Grid(searchNotifier: searchNotifier)),
          ],
        ),
      ),
      bottomNavigationBar:  BottomBar(),
    )
    );
  }
}
