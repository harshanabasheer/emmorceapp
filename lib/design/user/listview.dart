import 'package:flutter/material.dart';
import 'package:emmorceapp/model/listmodel.dart';


class CircleList extends StatefulWidget {
  const CircleList({super.key});

  @override
  State<CircleList> createState() => _CircleListState();
}

class _CircleListState extends State<CircleList> {

  List items=[
    ListModel(name: "Men", image: 'images/men.png'),
    ListModel(name: "Women", image: 'images/women.png'),
    ListModel(name: "Devices", image: 'images/bulb.png'),
    ListModel(name: "Gadgets", image: 'images/gadgets.jpg'),
    ListModel(name: "gaming", image: 'images/gaming.jpg'),
    ListModel(name: "Groceries", image: 'images/groceries.jpg'),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
        body:
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>ImagePage(name:items[index].name, image: items[index].image, subtitle: items[index].subtitle)));
              },
              child: Container(
                width: 80,
                height: 80,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.yellow,
                      backgroundImage: AssetImage(items[index].image),
                    ),
                    Text(
                      items[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        )

    );
  }
}