import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/model/categoryListModel.dart';
import 'package:emmorceapp/services/categoryService.dart';
import 'package:flutter/material.dart';

class CircleList extends StatefulWidget {
  const CircleList({super.key});

  @override
  State<CircleList> createState() => _CircleListState();
}

class _CircleListState extends State<CircleList> {
  ViewAllCategory client = ViewAllCategory();
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<CategoryListModel>(
            future: client.getAllCategory(),
            builder: (BuildContext context,
                AsyncSnapshot<CategoryListModel> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data!.data![index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundColor: selectedIndex == index ? Colors.red : Colors.black,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(Apiconstants.baseurl + data.categoryImage.toString()),
                              ),
                            ),
                            Text(
                              data.categoryName.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

