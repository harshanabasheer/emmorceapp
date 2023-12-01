import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/bottombar.dart';
import 'package:emmorceapp/design/user/paymentPage.dart';
import 'package:emmorceapp/model/cartModel.dart';
import 'package:emmorceapp/model/orderModelSingle.dart';
import 'package:emmorceapp/services/cartService.dart';
import 'package:emmorceapp/services/orderService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartListPage extends StatefulWidget {
  @override
  State<CartListPage> createState() => _CartListPageState();
}

class _CartListPageState extends State<CartListPage> {
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

  CartList client=CartList();
  OrderList clientOrder=OrderList();

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
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<CartItems>(
                future: client.getAllCart(),
                builder: (BuildContext context, AsyncSnapshot<CartItems>snapshot){
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
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.save_alt,color: Colors.black45,),
                                          Text("Save for later",style: TextStyle(color: Colors.black45)),
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
                                          Icon(Icons.delete,color: Colors.black45,),
                                          Text("Remove",style: TextStyle(color: Colors.black45),),
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
                  return Center(child:Text("Cart is Empty"));
                }
            ),
          ),
          userid == null ? Center(child: CircularProgressIndicator(),):
          FutureBuilder(
          future: clientOrder.totalCartPrice(userid!),
          builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                "\$${snapshot.data['data']['TotalAmount']}",
                  style: TextStyle(color: Colors.black,fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: ()async {
                    setState(() {
                      client.getAllCart();
                    });
                    clientOrder.removeAllCartItems(userid!);
                    clientOrder.orderCartProduct(userid!);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>PaymentPage(totalAmount:snapshot.data['data']['TotalAmount'] ,)
                              ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(),
                  ),
                  child: Text('Place Oder'),
                ),
              ],
            ),
          );
      }
      return Center(child: CircularProgressIndicator(),);
    }
          ),
        ],
      ),


    );
  }
}


