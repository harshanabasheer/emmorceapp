import 'dart:io';
import 'package:emmorceapp/model/addCategoryModel.dart';
import 'package:emmorceapp/model/categoryListModel.dart';
import 'package:emmorceapp/services/addProductService.dart';
import 'package:emmorceapp/services/categoryService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? imageFile;
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.pop(context);
                      //  _openGallery(context);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();
                      Navigator.pop(context);
                      //  _opencamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _getFromGallery() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Handle the exception if something goes wrong
      print("Error picking image from gallery: $e");
    }
  }

  _getFromCamera() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Handle the exception if something goes wrong
      print("Error picking image from camera: $e");
    }
  }
  AddCategoryApi client=AddCategoryApi();
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Products"),
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
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: imageFile == null
                      ? Row(
                        children: [
                          Container(
                              width: 150,
                              height: 150,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/noimage.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: () {
                              //    _getFromGallery();
                              _showChoiceDialog(context);
                            },
                            child: Text("Upload Image"),
                          ),
                        ],
                      )
                      : Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Image.file(
                                imageFile!,
                                width: 150,
                                height: 200,
                                //  fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(),
                              onPressed: () {
                                //    _getFromGallery();
                                _showChoiceDialog(context);
                              },
                              child: Text("Upload Image"),
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                buildTextFormField("Name", _nameController, "Name is required"),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price is required';
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    hintText: "Price",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                buildTextFormField(
                    "Color", _colorController, "Color is required"),
                SizedBox(
                  height: 10,
                ),
                buildTextFormField("Description", _descriptionController,
                    "Description is required"),
                SizedBox(
                  height: 10,
                ),
                // buildTextFormField(
                //     "Category", _categoryController, "Category is required"),
                FutureBuilder<List<AddCategoryModel>>(
                  future: client.getAllCategory(),
                  builder: (BuildContext context, AsyncSnapshot<List<AddCategoryModel>> snapshot) {
                    if (snapshot.hasData) {
                      List<AddCategoryModel> categoryList = (snapshot.data!);
                      return DropdownButtonFormField<String>(
                        value: selectedCategory,
                        onChanged: ( value) {
                          setState(() {
                            selectedCategory = value;
                          });
                        },
                        items:categoryList.map((category) {
                          return DropdownMenuItem<String>(
                            value: category.id.toString(),
                            child: Text(category.categoryName),

                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: "Category",
                          hintText: "Select a category",
                          errorText: selectedCategory == null ? "Category is required" : null,
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),




                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    AddProductApi.product(
                      context,
                      _nameController.text,
                      _priceController.text,
                      _colorController.text,
                      _descriptionController.text,
                      _categoryController.text,
                      imageFile,
                    );
                  },
                  child: Text("Add Product"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField(hint, controller, message) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return message;
        }
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black),
        ),
        hintText: hint,
      ),
    );
  }
}
