import 'package:flutter/material.dart';

class ViewOrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Orders"),
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
      body: OrderList(),
    );
  }
}

class OrderList extends StatelessWidget {
  final List<String> products = [
    'Order 1',
    'Order 2',
    'Order 3',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final productName = products[index];
        return Card(
          child: ListTile(
            title: Text(productName),
          ),
        );
      },
    );
  }
}
