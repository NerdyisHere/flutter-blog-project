import 'package:flutter/material.dart';

class LoginRegister extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

class _LoginRegisterState extends State<LoginRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Digital Front Gaming Blog"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
    );
  }
}
