import 'package:flutter/material.dart';

import '../../model/viewUserModel.dart';
import '../../services/viewUserService.dart';

class ViewUsersPage extends StatelessWidget {
  AllUser client=AllUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("View Users"),
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
      body:FutureBuilder<ViewUsers>(
          future: client.getAllUsers(),
          builder: (BuildContext context, AsyncSnapshot<ViewUsers>snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data?.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  var data=snapshot.data!.data![index];
                  return Card(
                    child: ListTile(
                      title: Text(data.name.toString()),
                      subtitle: Column(
                        crossAxisAlignment:CrossAxisAlignment.start ,
                        children: [
                          Text(data.email.toString()),
                          Text(data.phone.toString()),
                        ],
                      ),

                    ),
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator(),);
          }
      )
    );
  }
}

