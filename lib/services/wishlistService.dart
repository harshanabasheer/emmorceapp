import 'dart:convert';
import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/model/whishListModel.dart';
import 'authdata.dart';

class Whishlist {
  Future<AllWishlist> getAllWhishlist() async {
    var response = await ApiServices().getdata(Apiconstants.all_whishlist);
    var body = json.decode(response.body);
    print("body{$body}");
    if(body["success"]==true){
      var body = json.decode(response.body);
      AllWishlist _data = AllWishlist.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }

  Future<AllWishlist> removeWhishlist(int productId) async {
    var response = await ApiServices()
        .deletedata(Apiconstants.remove_wishlist + productId.toString());
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      AllWishlist _data = AllWishlist.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }

}
