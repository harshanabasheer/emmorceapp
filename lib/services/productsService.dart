import 'dart:convert';
import 'dart:io';
import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/seller/manageProduct.dart';
import 'package:emmorceapp/model/productsModel.dart';
import 'package:flutter/material.dart';
import 'authdata.dart';
import 'package:http/http.dart' as http;

class ViewAllProducts {
  Future<AllProducts> getAllProducts() async {
    var response = await ApiServices().getdata(Apiconstants.all_products);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      AllProducts _data = AllProducts.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }

  Future<AllProducts> deleteProduct(int productId) async {
    var response = await ApiServices()
        .deletedata(Apiconstants.delete_product + productId.toString());
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      AllProducts _data = AllProducts.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }

  Future<AllProducts> updateProduct(
      BuildContext context,
      int id,
      String name,
      String price,
      String color,
      String description,
      String category,
      File? imageFile) async {
    final urls =
        Apiconstants.baseurl + Apiconstants.update_product + id.toString();

    var request = await http.MultipartRequest('PUT', Uri.parse(urls));
    request.fields["ProductName"] = name;
    request.fields["Price"] = price;
    request.fields["Description"] = description;
    request.fields["Color"] = color;
    request.fields["Category"] = category;
    print("request ${request.fields}");
    if (imageFile != null) {
      final imageStream = http.ByteStream(imageFile!.openRead());
      final imageLength = await imageFile!.length();
      final multipartFile = await http.MultipartFile(
        'ProductImage',
        imageStream,
        imageLength,
        filename: imageFile.path.split('/').last,
      );
      request.files.add(multipartFile);
      print("filename ${imageFile.path.split('/').last}");
    } else {}
    final response = await request.send();
    if (response.statusCode == 200) {
      print('Form submitted successfully');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ManageProduct()));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Updated Succefully")));

      return AllProducts.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      print('Error submitting form. Status code: ${response.statusCode}');
      throw Exception('Failed to update product');
    }
  }
}
