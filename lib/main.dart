import 'package:flutter/material.dart';
import 'package:flutter_blog_project_2009853/Home.dart';
import 'LoginRegisterPage.dart';

void main() {
  // Main function that allows the app to run
  runApp(BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Digital Front Gaming Blog",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Home(),
    );
  }
}
