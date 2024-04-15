import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BlogPhotoUpload extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _BlogPhotoUploadState();
  }
}

class _BlogPhotoUploadState extends State<BlogPhotoUpload> {
  File? blogSampleImage;
  String? _BlogValue;
  final formKey = new GlobalKey<FormState>();
  Future getBlogImage() async {
    var blogTempImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (blogTempImage != null) {
        blogSampleImage = File(blogTempImage.path);
      }
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form?.validate() ?? false) {
      form?.save();
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Blog Image"),
        centerTitle: true,
      ),
      body: Center(
        child: blogSampleImage == null
            ? Text("Please select an image to upload")
            : enableUpload(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getBlogImage,
        tooltip: 'Add Image',
        child: IconButton(
            color: Colors.green,
            iconSize: 50,
            icon: Icon(Icons.add_a_photo_outlined),
            onPressed: null),
      ),
    );
  }

  Widget enableUpload() {
    return Container(
        child: Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Image.file(
            blogSampleImage!,
            height: 340.00,
            width: 670,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Description"),
            validator: (value) {
              return value!.isEmpty
                  ? 'A blog description is required to continue'
                  : null;
            },
            onSaved: (value) {
              _BlogValue = value!;
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              onPressed: validateAndSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
              ),
              child: Text("Add a New Blog Post",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.green,
                  ))),
        ],
      ),
    ));
  }
}
