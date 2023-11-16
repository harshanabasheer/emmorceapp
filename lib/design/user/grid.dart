import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/user/productDetailPage.dart';
import 'package:emmorceapp/model/productsModel.dart';
import 'package:emmorceapp/services/productsService.dart';
import 'package:flutter/material.dart';

class Grid extends StatefulWidget {
  const Grid({Key? key});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  ViewAllProducts client = ViewAllProducts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: FutureBuilder(
            future: client.getAllProducts(),
            builder:
                (BuildContext context, AsyncSnapshot<AllProducts> snapshot) {
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(productId: data.id!)),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              Apiconstants.baseurl +
                                  data.productImage.toString(),
                              height: 100,
                              width: 100,
                            ),
                            Text(data.productName.toString()),
                            Text(data.price.toString()),
                            Text(data.description.toString()),
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
            },
          ),
        ),
      ),
    );
  }
}
