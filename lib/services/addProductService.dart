import 'dart:convert';
import 'dart:io';
import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/seller/manageProduct.dart';
import 'package:emmorceapp/model/addProductModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProductApi {

  static Future<AddProduct> product(BuildContext context,
      String name, String price, String color, String description, String category,
      File? imageFile ) async {

    final urls = Apiconstants.baseurl + Apiconstants.add_product;
    print(urls);

    var request = await http.MultipartRequest('POST', Uri.parse(urls));
    /*request.fields["plantId"] = pl.toString();*/
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
    } else {
      // Handle the case where imageFile is null or provide a default image
      // You can choose to throw an error, use a default image, or handle it differently.
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      print('Form submitted successfully');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ManageProduct()));

      return AddProduct.fromJson(jsonDecode(await response.stream.bytesToString()));
    } else {
      print('Error submitting form. Status code: ${response.statusCode}');
      throw Exception('Failed to add product');
    }
  }




}