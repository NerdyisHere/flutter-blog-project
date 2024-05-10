import 'package:flutter/material.dart';
import 'Auth.dart';
import 'DialogBox.dart';
// This is the main widget for the login and registration screen

class LoginRegister extends StatefulWidget {
  LoginRegister({this.auth, this.onSignedIn});

  final AuthImplementation?
      auth; // Reference to the authentication implementation

  final VoidCallback?
      onSignedIn; // Callback function to be called after successful login/registration

  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

enum FormType {
  login,
  register
} // Enum to represent the form type (login or register)

class _LoginRegisterState extends State<LoginRegister> {
  DialogBox dialog =
      DialogBox(); // Instance of the DialogBox widget for displaying messages
  final formKey = new GlobalKey<FormState>(); // Global key for the form

  FormType _formType = FormType.login; // Initial form type is set to login

  // ignore: unused_field
  String _email = ""; // Variable to store the email input
  // ignore: unused_field
  String _password = ""; // Variable to store the password input

  // Validates the form fields and saves the input values

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  // Validates the form and performs login or registration based on the form type

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await widget.auth!.signIn(_email, _password);
          dialog.information(
              context, "Nice = ", "You have signed into your blog account");
          print("login userID = " + userId);
        } else {
          String userId = await widget.auth!.signUp(_email, _password);
          dialog.information(
              context, "Congrats = ", "Your blog account has been created.");
          print("Register userID = " + userId);
        }
        widget.onSignedIn!();
      } catch (e) {
        dialog.information(context, "Error = ", e.toString());
        print("Error = " + e.toString());
      }
    }
  }

  // Changes the form type to register

  void moveToRegister() {
    formKey.currentState?.reset();

    setState(() {
      _formType = FormType.register;
    });
  }
  // Changes the form type to login

  void moveToLogin() {
    formKey.currentState?.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  // Build method to render the UI
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

  // Creates the input fields (email and password)
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

  // Renders the logo
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

  // Creates the buttons (login/register and form type toggle)
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
