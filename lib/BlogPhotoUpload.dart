import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'Auth.dart';
import 'Home.dart';
import 'Mapping.dart';

class BlogPhotoUpload extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _BlogPhotoUploadState();
  }
}

class _BlogPhotoUploadState extends State<BlogPhotoUpload> {
  File? blogSampleImage;
  String? _blogValue;

  String? url;
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

  void uploadBlogStatusImage() async {
    if (validateAndSave()) {
      final Reference imageReference =
          FirebaseStorage.instance.ref().child("Post Blog Images");

      var blogTimeKey = DateTime.now();

      try {
        final UploadTask blogUploadTask = imageReference
            .child(blogTimeKey.toString() + ".jpg")
            .putFile(blogSampleImage!);

        var blogImageURL = await (await blogUploadTask).ref.getDownloadURL();

        if (blogImageURL != null) {
          url = blogImageURL.toString();
          print("Blog Image =" + url!);

          goToBlogHomePage();

          saveToBlogDatabase(url!); // Ensure url is not null before passing it
        } else {
          // Handle case where blogImageURL is null
          print("Failed to get blog image URL");
        }
      } catch (e) {
        // Handle any exceptions that occur during the upload process
        print("Error uploading image: $e");
      }
    }
  }

  void saveToBlogDatabase(String url) {
    try {
      var dbBlogTimeKey = DateTime.now();
      var blogFormatDate = DateFormat('MMM d, yyyy');
      var blogFormatTime = DateFormat('EEEE, hh:mm aaa');

      String date = blogFormatDate.format(dbBlogTimeKey);
      String time = blogFormatTime.format(dbBlogTimeKey);

      DatabaseReference ref = FirebaseDatabase.instance.ref();

      var data = {
        "image": url,
        "description": _blogValue,
        "date": date,
        "time": time,
      };

      ref.child("Blog Posts").push().set(data);
    } catch (e) {
      // Handle any exceptions that occur during the database operation
      print("Error saving to database: $e");
    }
  }

  void goToBlogHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Home(); // Return an instance of the Home widget
    }));
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
              _blogValue = value!;
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          ElevatedButton(
              onPressed: uploadBlogStatusImage,
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
