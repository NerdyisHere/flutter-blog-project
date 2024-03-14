import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Digital Front Home Page"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Container(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: Container(
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
              IconButton(
                  color: Colors.green,
                  iconSize: 50,
                  icon: Icon(Icons.local_car_wash_outlined),
                  onPressed: null),
              IconButton(
                  color: Colors.green,
                  iconSize: 50,
                  icon: Icon(Icons.add_a_photo_outlined),
                  onPressed: null),
            ])),
      ),
    );
  }
}
