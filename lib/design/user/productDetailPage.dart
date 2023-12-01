import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/bottombar.dart';
import 'package:emmorceapp/design/user/cartListPage.dart';
import 'package:emmorceapp/design/user/paymentPage.dart';
import 'package:emmorceapp/model/cartModel.dart';
import 'package:emmorceapp/model/orderModelSingle.dart';
import 'package:emmorceapp/model/reviewModel.dart';
import 'package:emmorceapp/model/whishListModel.dart';
import 'package:emmorceapp/services/authdata.dart';
import 'package:emmorceapp/services/cartService.dart';
import 'package:emmorceapp/services/orderService.dart';
import 'package:emmorceapp/services/reviewService.dart';
import 'package:emmorceapp/services/wishlistService.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  ProductDetailPage({required this.productId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final CarouselController _carouselController = CarouselController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  CartList cartClient=CartList();
  OrderList clientOrder=OrderList();
  late SharedPreferences prefs;
  late int userid;
  int _currentIndex = 0;
  bool _isWishlisted = false;
  bool _isAddingToWishlist = false;
  String imageUrl = '';
  String proname = '';
  String proprice = '';
  String prodesc = '';
  String proimage = '';
  var rating;
  Future<void> _fetchProductDetails(int productId) async {
     prefs = await SharedPreferences.getInstance();
    userid= (prefs.getInt('userid') ?? 0);

    final response = await ApiServices().getdata(
      Apiconstants.one_product + productId.toString(),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      setState(() {
        imageUrl = body['data']['ProductImage'];
        proname = body['data']['ProductName'];
        proprice = body['data']['Price'];
        prodesc = body['data']['Description'];
        proimage = body['data']['ProductImage'];
        _nameController.text = proname;
        _priceController.text = proprice;
        _descriptionController.text = prodesc;
      });
    } else {}
  }
  bool _isAddedToCart = false;
  bool _isLoading = false;
  Future<void> _addToCart(int userId, int productId) async {
    var data={
      "UserId":userId.toString(),
      "ProductId":productId.toString(),
    };
    // print("data{$data}");
    final response = await ApiServices().postdata(data, Apiconstants.add_to_cart);
    var body = json.decode(response.body);

    if(body["success"]==true){
     CartItems cartList= await cartClient.getAllCart();
     cartLengthNotify.value  = cartList.data!.length;

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(body["message"])));
      setState(() {
        _isAddedToCart = true;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(body["message"])));
    }
  }
  Whishlist client=Whishlist();
  Review clientReview=Review();
  Future<void> _addToWishlist(int userId, int productId) async {
    if (_isAddingToWishlist) {
      return;
    }
    setState(() {
      _isAddingToWishlist = true;
    });

    var data = {
      "UserId": userId.toString(),
      "ProductId": productId.toString(),
    };
    try {
      if (_isWishlisted) {
       await client.removeWhishlist(productId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product removed from wishlist'),
          ),
        );
      } else {
        final response = await ApiServices().postdata(data, Apiconstants.add_to_wishlist);
        var body = json.decode(response.body);

        if (body["success"] == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(body["message"])));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(body["message"])));
        }
      }
      setState(() {
        _isWishlisted = !_isWishlisted;
      });
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        _isAddingToWishlist = false;
      });
    }
  }


  Future _itemCheck()async{
    setState(() {
      _isLoading=true;
    });
    CartItems item =await cartClient.getAllCart();
    for (var oneItem in item.data!) {
      if(widget.productId.toString() == oneItem.productId){
        _isAddedToCart=true;
      }
    }
    setState(() {
      _isLoading=false;

    });
  }
  Future _itemCheckWhishlist()async{
    setState(() {
      _isLoading=true;
    });
    AllWishlist item =await client.getAllWhishlist();
    for (var oneItem in item.data!) {
      if(widget.productId.toString() == oneItem.productId){
        _isWishlisted=true;
      }
    }
    setState(() {
      _isLoading=false;

    });
  }


  @override
  void initState() {
    super.initState();
    _fetchProductDetails(widget.productId);
    _itemCheck();
    _itemCheckWhishlist();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
        titleSpacing: 00.0,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        elevation: 0.00,
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading ? Center(child: CircularProgressIndicator()):
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    items: [
                      Image.network(Apiconstants.baseurl + proimage.toString()),
                      Image.network(Apiconstants.baseurl + proimage.toString()),
                      Image.network(Apiconstants.baseurl + proimage.toString()),
                      Image.network(Apiconstants.baseurl + proimage.toString()),
                    ],
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child:IconButton(
                      onPressed: (){
                        _addToWishlist(userid, widget.productId);
                      },
                      icon:_isWishlisted?Icon(Icons.favorite,color: Colors.red,):
                      Icon(Icons.favorite_border,color: Colors.blue,),
                    ),

                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentIndex == index ? Colors.blue : Colors.grey,
                      ),
                    ),
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_nameController.text,style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 8,),
                    Text("\$${_priceController.text}"),
                    Row(
                      children: [
                        Text(_descriptionController.text,style:TextStyle(color: Colors.blue),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            ignoreGestures: true,
                            tapOnlyMode: true,
                            itemCount: 5,
                            itemSize: 20,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) =>
                                Icon(Icons.star, color: Colors.amber),
                            onRatingUpdate: (rating) {
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FutureBuilder<ReviewModel>(
                    future: clientReview.getAllReview(),
                    builder: (BuildContext context, AsyncSnapshot<ReviewModel>snapshot){
                      if(snapshot.hasData){
                        return Container(
                          height: 250,
                          child:
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text("Rating & Reviews",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                    SizedBox(width: 130,),
                                    OutlinedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            double userRating = 0.0;
                                            return AlertDialog(
                                              title: Text("Rate This Product"),
                                              content: RatingBar.builder(
                                                initialRating: userRating,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: false,
                                                itemCount: 5,
                                                itemSize: 30,
                                                itemBuilder: (context, _) =>
                                                    Icon(Icons.star, color: Colors.amber),
                                                onRatingUpdate: (rating) {
                                                  userRating = rating; // Update the user's rating
                                                },
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Submit"),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: const Text('Rate Product',style: TextStyle(color: Colors.black),),
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.data?.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    var data=snapshot.data!.data![index];
                                     rating = data.rating != null ? data.rating! : 0.0;
                                    return Container(
                                      height: 80,
                                      child: Card(
                                        child:
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: RatingBar.builder(
                                                    initialRating: double.parse(rating),
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: false,
                                                    ignoreGestures: true,
                                                    tapOnlyMode: true,
                                                    itemCount: 5,
                                                    itemSize: 18,
                                                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(Icons.star, color: Colors.amber),
                                                    onRatingUpdate: (rating) {
                                                      // Handle rating update
                                                    },
                                                  ),

                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                    child: Text(data.review.toString())
                                                ),
                                                Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(data.userName.toString(),style: TextStyle(color: Colors.blue),)
                                                ),
                                              ],
                                            ),
                                      ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator(),);
                    }
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
      persistentFooterButtons:_isLoading?null: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                if (_isAddedToCart) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => CartListPage()));
                } else {
                  setState(() {
                    if (!_isAddedToCart) {
                      _addToCart(userid, widget.productId);
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                shape: RoundedRectangleBorder(),
              ),
              child: Text(
                _isAddedToCart ? "Go to Cart" : "Add to Cart",
                style: TextStyle(color: Colors.black, fontSize: 18,),
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                OrderModelSingle order = await clientOrder.orderSingleProduct(userid, widget.productId);
                // print("tottalamount${order.data?.totalAmount}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>PaymentPage(totalAmount: order.data!.totalAmount.toString(),)
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                shape: RoundedRectangleBorder(),
              ),
              child: Text(
                "Buy Now",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
