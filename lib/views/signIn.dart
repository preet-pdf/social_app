import 'package:flutter/material.dart';
import 'package:social_app/widgets/widgets.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
                child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                    style: simpleTextFieldStyle(),
                    decoration: textFieldInputDecoraion("Email")),
                TextField(
                    style: simpleTextFieldStyle(),
                    decoration: textFieldInputDecoraion("Password")),
                SizedBox(height: 8),
                Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "Forgot Password??",
                          style: simpleTextFieldStyle(),
                        ))),
                SizedBox(height: 8),
                Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ])),
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    )),
                SizedBox(height: 16),
                Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Text(
                      "Sign In With Google",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    )),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont Have account?",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                                          child: Container(
                        padding: EdgeInsets.symmetric(vertical:8),
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height:50,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
