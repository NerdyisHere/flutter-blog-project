import 'package:flutter/material.dart';
import 'Auth.dart';

class LoginRegister extends StatefulWidget {
  LoginRegister({required this.auth, required this.onSignedIn});

  final AuthImplementation auth;
  final VoidCallback onSignedIn;

  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

enum FormType { login, register }

class _LoginRegisterState extends State<LoginRegister> {
  final formKey = new GlobalKey<FormState>();

  FormType _formType = FormType.login;

  // ignore: unused_field
  String _email = "";
  // ignore: unused_field
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

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth.signIn(_email, _password);
          print("login userID = " + userId);
        } else {
          String userId = await widget.auth.signUp(_email, _password);
          print("Register userID = " + userId);
        }
        widget.onSignedIn();
      } catch (e) {
        print("Error = " + e.toString());
      }
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
        title: Text("Digital Front Gaming Blog"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
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
      SizedBox(
        height: 10.0,
      ),
      logo(),
      SizedBox(
        height: 20.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
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
      SizedBox(
        height: 10.0,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
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
      SizedBox(
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
            onPressed: validateAndSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
            ),
            child: Text("Login", style: TextStyle(fontSize: 20.0))),
        TextButton(
            onPressed: moveToRegister,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
            ),
            child: Text("You don't have a blog account? Create an account!",
                style: TextStyle(fontSize: 15.0))),
      ];
    } else {
      return [
        ElevatedButton(
            onPressed: validateAndSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
            ),
            child: Text("Create Account", style: TextStyle(fontSize: 20.0))),
        TextButton(
            onPressed: moveToLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.green,
            ),
            child: Text("Already have an account? Login now!",
                style: TextStyle(fontSize: 15.0))),
      ];
    }
  }
}
