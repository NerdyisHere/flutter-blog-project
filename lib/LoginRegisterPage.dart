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
      body: Container(
        margin: const EdgeInsets.all(15.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      const SizedBox(
        height: 10.0,
      ),
      logo(),
      const SizedBox(
        height: 20.0,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Email'),
      ),
      const SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Password'),
      ),
      const SizedBox(
        height: 20.0,
      ),
    ];
  }

  Widget logo() {
    return Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 110.0,
        child: Image.asset('images/digital-front-logo.png'),
      ),
    );
  }

  List<Widget> createButtons() {
    return [
      ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
          ),
          child: const Text("Login", style: TextStyle(fontSize: 20.0))),
      TextButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.green,
          ),
          child: const Text("You don't have a blog account? Create an account!",
              style: TextStyle(fontSize: 15.0))),
    ];
  }
}
