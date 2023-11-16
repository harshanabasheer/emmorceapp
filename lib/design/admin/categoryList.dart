import 'package:draggable_fab/draggable_fab.dart';
import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/admin/addCategory.dart';
import 'package:emmorceapp/model/categoryListModel.dart';
import 'package:emmorceapp/services/categoryService.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  ViewAllCategory client=ViewAllCategory();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
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
      body: FutureBuilder<CategoryListModel>(
          future: client.getAllCategory(),
          builder: (BuildContext context, AsyncSnapshot<CategoryListModel>snapshot){
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
                            image: DecorationImage(image: NetworkImage(Apiconstants.baseurl+data.categoryImage.toString()))),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.categoryName.toString()),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete,color: Colors.red,),
                            onPressed: () {
                              setState(() {
                                if (data.id != null) {
                                  client.deleteCategory(data.id!.toInt());
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddCategory()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}


