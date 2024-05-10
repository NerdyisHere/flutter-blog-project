import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog_project_2009853/Auth.dart';
import 'Auth.dart';
import 'BlogPhotoUpload.dart';
import 'BlogPosts.dart';

class Home extends StatefulWidget {
  Home({
    this.auth,
    this.onSignedOut,
  });

  final AuthImplementation? auth;
  final VoidCallback? onSignedOut;

  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<BlogPosts> blogPostList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    DatabaseReference postsBlogRef =
        FirebaseDatabase.instance.ref().child("Blog Posts");

    postsBlogRef.once().then((DatabaseEvent snap) {
      DataSnapshot dataSnapshot = snap.snapshot;
      var KEYS = (dataSnapshot.value as Map?)?.keys.toList();
      var DATA = dataSnapshot.value as Map?;

      blogPostList.clear();

      for (var individualBlogKey in KEYS!) {
        BlogPosts posts = BlogPosts(
          DATA?[individualBlogKey]['image'],
          DATA?[individualBlogKey]['description'],
          DATA?[individualBlogKey]['date'],
          DATA?[individualBlogKey]['time'],
        );
        blogPostList.add(posts);
      }
      setState(() {
        print('Length: $blogPostList.length');
      });
    });
  }

  void _logoutUser() async {
    try {
      await widget.auth!.signOut();
      widget.onSignedOut!();
    } catch (e) {
      print("Error = " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Digital Front Home"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(
          child: blogPostList.length == 0
              ? Text("No Blog Post avaliable")
              : ListView.builder(
                  itemCount: blogPostList.length,
                  itemBuilder: (_, index) {
                    return BlogPostsUI(
                      blogPostList[index].image,
                      blogPostList[index].description,
                      blogPostList[index].date,
                      blogPostList[index].time,
                    );
                  })),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
              IconButton(
                  color: Colors.white,
                  iconSize: 50,
                  icon: Icon(Icons.logout),
                  onPressed: _logoutUser),
              IconButton(
                  color: Colors.white,
                  iconSize: 50,
                  icon: Icon(Icons.add_a_photo_outlined),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return BlogPhotoUpload();
                    }));
                  }),
            ])),
      ),
    );
  }

  Widget BlogPostsUI(
    String? image,
    String? description,
    String? date,
    String? time,
  ) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  date!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  time!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Image.network(image!, fit: BoxFit.cover),
            Text(
              description!,
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
