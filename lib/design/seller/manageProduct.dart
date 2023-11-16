import 'package:draggable_fab/draggable_fab.dart';
import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/seller/addProduct.dart';
import 'package:emmorceapp/design/seller/updateProduct.dart';
import 'package:emmorceapp/model/productsModel.dart';
import 'package:emmorceapp/services/productsService.dart';
import 'package:flutter/material.dart';

class ManageProduct extends StatefulWidget {
  @override
  State<ManageProduct> createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {

  ViewAllProducts client=ViewAllProducts();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
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
      body: FutureBuilder<AllProducts>(
          future: client.getAllProducts(),
          builder: (BuildContext context, AsyncSnapshot<AllProducts>snapshot){
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
                            image: DecorationImage(image: NetworkImage(Apiconstants.baseurl+data.productImage.toString()))),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.productName.toString()),
                          Text("\$${data.price.toString()}"),
                          Text(data.description.toString()),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit,color: Colors.blue,),
                            onPressed: () {
                              // setState(() {
                              //   if (data.id != null) {
                              //     client.oneProduct(data.id!.toInt(), context: context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateProducts(id:data.id!,)));
                              //   }
                              // });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,color: Colors.red,),
                            onPressed: () {
                              setState(() {
                                if (data.id != null) {
                                  client.deleteProduct(data.id!.toInt());
                                }
                              });
                            },
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
      floatingActionButton:DraggableFab(
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddProducts()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}


