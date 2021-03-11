import 'package:flutter/material.dart';
import 'package:social_app/views/signIn.dart';
import 'package:social_app/views/signUp.dart';

class Authnticate extends StatefulWidget {
  @override
  _AuthnticateState createState() => _AuthnticateState();
}

class _AuthnticateState extends State<Authnticate> {
  bool showSignIN = true;
  void toggleView() {
    setState(() {
      showSignIN = !showSignIN;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIN) {
      return SignIn(toggleView);
    } else {
      return SignUp(toggleView);
    }
    
  }
}
