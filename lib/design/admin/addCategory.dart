import 'dart:io';
import 'package:emmorceapp/services/categoryService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController _nameController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Add Category"),
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
                TextFormField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price is required';
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    hintText: "Category name",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    AddCategoryApi.category(
                      context,
                      _nameController.text,
                      imageFile,
                    );
                  },
                  child: Text("Add Category"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
