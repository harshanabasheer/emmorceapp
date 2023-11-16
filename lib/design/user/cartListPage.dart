import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/bottombar.dart';
import 'package:emmorceapp/model/cartModel.dart';
import 'package:emmorceapp/services/cartService.dart';
import 'package:flutter/material.dart';

class CartListPage extends StatefulWidget {
  @override
  State<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {

  CartList client=CartList();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        titleSpacing: 00.0,
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
      body: FutureBuilder<CartItems>(
          future: client.getAllCart(),
          builder: (BuildContext context, AsyncSnapshot<CartItems>snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  var data=snapshot.data!.data![index];
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading:
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(Apiconstants.baseurl+data.productImage.toString()))
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.productName.toString()),
                              Text("\$${data.price.toString()}"),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                },
                                child: Row(
                                  children: [
                                    Icon(Icons.save_alt,color: Colors.black,),
                                    Text("Save for later",style: TextStyle(color: Colors.black)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    if (data.id != null) {
                                      client.removeFromCart(data.id!.toInt());
                                    }
                                  });
                                },
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.delete,color: Colors.black,),
                                    Text("Remove",style: TextStyle(color: Colors.black),),
                                  ],
                               )
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),

                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator(),);
          }
      ),
    );
  }
}


