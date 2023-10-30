import 'package:flutter/material.dart';
import 'package:emmorceapp/design/user/listview.dart';
import 'package:emmorceapp/design/user/grid.dart';
import 'package:emmorceapp/design/bottombar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Our Products",style:TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
        backgroundColor: Colors.white,
        actions: const [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey,
            child: Icon(Icons.search,color: Colors.white,)
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
      bottomNavigationBar: const BottomBar(),



    );
  }
}
