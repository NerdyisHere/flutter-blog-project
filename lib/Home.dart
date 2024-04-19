import 'package:flutter/material.dart';
import 'package:flutter_blog_project_2009853/Auth.dart';
import 'Auth.dart';
import 'BlogPhotoUpload.dart';

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
      body: Container(),
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
                  icon: Icon(Icons.local_car_wash_outlined),
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
}
