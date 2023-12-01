import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/model/orderModelCart.dart';
import 'package:emmorceapp/services/orderService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderListPage extends StatefulWidget {
  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  late SharedPreferences prefs;
  int  ? userid;

  void initState() {
    super.initState();
    _initializeUserID();
  }

  Future<void> _initializeUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getInt('userid') ?? 0);
    });
  }

  OrderList clientOrder=OrderList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<OrderModelCart>(
                future: clientOrder.getAllOrders(),
                builder: (BuildContext context, AsyncSnapshot<OrderModelCart>snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.data?.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data=snapshot.data!.data![index];
                        return Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading:
                                Container(
                                  height: 200,
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


                            ],
                          ),

                        );
                      },
                    );
                  }
                  return Center(child:CircularProgressIndicator());
                }
            ),
          ),

        ],
      ),


    );
  }
}


