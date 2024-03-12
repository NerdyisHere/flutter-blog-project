import 'package:flutter/material.dart';

class LoginRegister extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

enum FormType { login, register }

class _LoginRegisterState extends State<LoginRegister> {
  final formKey = new GlobalKey<FormState>();

  FormType _formType = FormType.login;

  String _email = "";
  String _password = "";
  // Methods

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void moveToRegister() {
    formKey.currentState?.reset();

    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState?.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  // Design
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
          key: formKey,
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter an email';
          }
          return null;
        },
        onSaved: (value) {
          _email = value!;
        },
      ),
      const SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: const InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter an password';
          }
          return null;
        },
        onSaved: (value) {
          _password = value!;
        },
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
    if (_formType == FormType.login) {
      return [
        ElevatedButton(
            onPressed: validateAndSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
            ),
            child: const Text("Login", style: TextStyle(fontSize: 20.0))),
        TextButton(
            onPressed: moveToRegister,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
            ),
            child: const Text(
                "You don't have a blog account? Create an account!",
                style: TextStyle(fontSize: 15.0))),
      ];
    } else {
      return [
        ElevatedButton(
            onPressed: validateAndSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
            ),
            child:
                const Text("Create Account", style: TextStyle(fontSize: 20.0))),
        TextButton(
            onPressed: moveToLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
            ),
            child: const Text("Already have an account? Login now!",
                style: TextStyle(fontSize: 15.0))),
      ];
    }
  }
}
