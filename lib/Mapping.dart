// ignore_for_file: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginRegisterPage.dart';
import 'Home.dart';
import 'Auth.dart';

class MappingPage extends StatefulWidget {
  final AuthImplementation auth;

  MappingPage({
    required this.auth,
  });
  State<StatefulWidget> createState() {
    return _MappingPageState();
  }
}

enum AuthStatus { notSignedIn, signedIn }

class _MappingPageState extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.getCurrentUser().then((userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginRegister(auth: widget.auth, onSignedIn: _signedIn);

      case AuthStatus.signedIn:
        return Home(auth: widget.auth, onSignedOut: _signedOut);
    }
  }
}
