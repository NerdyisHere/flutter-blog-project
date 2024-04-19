import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_project_2009853/Auth.dart';
import 'package:flutter_blog_project_2009853/Mapping.dart';
import 'LoginRegisterPage.dart';
import 'Mapping.dart';
import 'Auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
          apiKey: "AIzaSyBoKRiFCvT0vfJmSKuYEWlEx5LzANT2o9w",
          authDomain: "blog-app-project-200953.firebaseapp.com",
          projectId: "blog-app-project-200953",
          storageBucket: "blog-app-project-200953.appspot.com",
          messagingSenderId: "226401897171",
          appId: "1:226401897171:web:e856ae24fb639e0d9a6226",
        ))
      : await Firebase.initializeApp();
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
      home: MappingPage(
        auth: Auth(),
      ),
    );
  }
}
