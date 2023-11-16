import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/model/categoryListModel.dart';
import 'package:emmorceapp/services/categoryService.dart';
import 'package:flutter/material.dart';

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({Key? key});

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  ViewAllCategory client=ViewAllCategory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: FutureBuilder(
            future: client.getAllCategory(),
            builder: (BuildContext context, AsyncSnapshot<CategoryListModel> snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data?.data?.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data!.data![index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                        // color: Colors.blueGrey,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            Apiconstants.baseurl+data.categoryImage.toString(),
                            height: 100,
                            width: 100,
                          ),
                          Text(data.categoryName.toString()),
                        ],
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
