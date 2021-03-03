import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text("CharuSocial"),
  );
}

InputDecoration textFieldInputDecoraion(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextFieldStyle() {
  return TextStyle(color: Colors.white,
  fontSize: 16
  );
}
