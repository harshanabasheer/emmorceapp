import 'package:draggable_fab/draggable_fab.dart';
import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/seller/addProduct.dart';
import 'package:emmorceapp/model/whishListModel.dart';
import 'package:emmorceapp/services/wishlistService.dart';
import 'package:flutter/material.dart';

class WhishListPage extends StatefulWidget {
  @override
  State<WhishListPage> createState() => _WhishListPageState();
}

class _WhishListPageState extends State<WhishListPage> {

  Whishlist client=Whishlist();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Whishlist"),
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
      body: FutureBuilder<AllWishlist>(
          future: client.getAllWhishlist(),
          builder: (BuildContext context, AsyncSnapshot<AllWishlist>snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  var data=snapshot.data!.data![index];
                  return Card(
                    child: ListTile(
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
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                if (data.id != null) {
                                  client.removeWhishlist(data.id!.toInt());
                                }
                              });
                            },
                            icon: Icon(Icons.close, size: 24.0,color: Colors.red,),
                            label: Text('Remove',style: TextStyle(color: Colors.red),),
                          ),
                        ],
                      ),
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


