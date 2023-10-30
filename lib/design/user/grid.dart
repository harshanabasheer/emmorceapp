import 'package:flutter/material.dart';
import 'package:emmorceapp/model/gridmodel.dart';

class Grid extends StatefulWidget {
  const Grid({super.key});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  List items = [
    GridItems(img: 'images/watch.jpg', name: 'Watch\n20000'),
    GridItems(img: 'images/wallet.jpg', name: 'Wallet\n200'),
    GridItems(img: 'images/phone.jpg', name: 'Phone\n15000'),
    GridItems(img: 'images/sofa.jpg', name: 'Sofa\n10000'),
    GridItems(img: 'images/shoemen.jpeg', name: 'Shoe\n2000'),
    GridItems(img: 'images/laptop.jpeg', name: 'Laptop\n50000'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child:GridView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(items[index].img, height: 120, width: 120),
                    Text(items[index].name, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            },
          )

        ),
      ),
    );
  }
}
