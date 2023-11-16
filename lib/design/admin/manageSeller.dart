import 'package:emmorceapp/model/manageSellerModel.dart';
import 'package:emmorceapp/services/manageSellerService.dart';
import 'package:flutter/material.dart';

class ManageSellerPage extends StatefulWidget {
  @override
  _ManageSellerPageState createState() => _ManageSellerPageState();
}

class _ManageSellerPageState extends State<ManageSellerPage> {
  AllSeller client = AllSeller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Seller"),
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
      body:ListView(
        children:[
          Column(
              children: [
                FutureBuilder<ManageSeller>(
                    future: client.getAllSellers(),
                    builder: (BuildContext context, AsyncSnapshot<ManageSeller>snapshot){
                      if(snapshot.hasData){
                        return  Column(
                          children: [
                            Card(
                                color: Colors.blue,
                                child: ListTile(
                                  title: Text("All Sellers"),
                                )
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.data?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data=snapshot.data!.data![index];
                                  return Card(
                                    child: ListTile(
                                      title: Text(data.name.toString()),
                                      subtitle: Text(data.email.toString()),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (data.id != null) {
                                                  client.acceptSeller(data.id!.toInt(), context: context);
                                                }
                                              });

                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.green,
                                            ),
                                            child: Text('Accept'),
                                          ),
                                          SizedBox(width: 8),
                                          ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                if (data.login != null) {
                                                  client.deleteSeller(data.login!.toInt());
                                                }
                                              });
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.red,
                                            ),
                                            child: Text('Reject',style: TextStyle(color: Colors.black),),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        );
                      }
                      return Center(child: CircularProgressIndicator(),);
                    }
                ),
                FutureBuilder<ManageSeller>(
                    future: client.getAllSellersAccpted(),
                    builder: (BuildContext context, AsyncSnapshot<ManageSeller>snapshot){
                      if(snapshot.hasData){
                        return  Column(
                          children: [
                            Card(
                                color: Colors.blue,
                                child: ListTile(
                                  title: Text("All Sellers"),
                                )
                            ),
                            ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.data?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var data=snapshot.data!.data![index];
                                  return Card(
                                    child: ListTile(
                                      title: Text(data.name.toString()),
                                      subtitle: Text(data.email.toString()),
                                    ),
                                  );
                                }),
                          ],
                        );
                      }
                      return Center(child: CircularProgressIndicator(),);
                    }
                ),
              ]),
        ]
      ),

    );
  }
}
