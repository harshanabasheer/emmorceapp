import 'dart:convert';
import 'dart:io';
import 'package:emmorceapp/constants/constants.dart';
import 'package:emmorceapp/design/admin/categoryList.dart';
import 'package:emmorceapp/model/addCategoryModel.dart';
import 'package:emmorceapp/model/categoryListModel.dart';
import 'package:emmorceapp/services/authdata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddCategoryApi {

  static Future<AddCategoryModel> category(BuildContext context,
      String name,
      File? imageFile ) async {

    final urls = Apiconstants.baseurl + Apiconstants.add_category;
    print(urls);

    var request = await http.MultipartRequest('POST', Uri.parse(urls));
    /*request.fields["plantId"] = pl.toString();*/
    request.fields["CategoryName"] = name;
    print("request ${request.fields}");

    if (imageFile != null) {
      final imageStream = http.ByteStream(imageFile!.openRead());
      final imageLength = await imageFile!.length();

      final multipartFile = await http.MultipartFile(
        'CategoryImage',
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CategoryList()));

      return AddCategoryModel.fromJson(jsonDecode(await response.stream.bytesToString()));
    } else {
      print('Error submitting form. Status code: ${response.statusCode}');
      throw Exception('Failed to add category');
    }
  }
  Future<List<AddCategoryModel>> getAllCategory() async {
    var response = await ApiServices().getdata(Apiconstants.all_category);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      List<AddCategoryModel>_data=List<AddCategoryModel>.from(body['data'].map((e)=>AddCategoryModel.fromJson(e)).toList());
     // CategoryListModel _data = CategoryListModel.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }

  Future<CategoryListModel> deleteCategory(int categoryId) async {
    var response = await ApiServices()
        .deletedata(Apiconstants.delete_category + categoryId.toString());
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      CategoryListModel _data = CategoryListModel.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }

}
class ViewAllCategory {
  Future<CategoryListModel> getAllCategory() async {
    var response = await ApiServices().getdata(Apiconstants.all_category);
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      CategoryListModel _data = CategoryListModel.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }

  Future<CategoryListModel> deleteCategory(int categoryId) async {
    var response = await ApiServices()
        .deletedata(Apiconstants.delete_category + categoryId.toString());
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      CategoryListModel _data = CategoryListModel.fromJson(body);
      return _data;
    } else {
      throw Exception('failed to load');
    }
  }

}