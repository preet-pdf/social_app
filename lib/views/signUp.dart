import 'package:flutter/material.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/services/database.dart';
import 'package:social_app/views/charRoomsScreen.dart';
import 'package:social_app/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
DataBaseMethods databaseMethods=new DataBaseMethods();
  TextEditingController usenameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  signMeUp() {
    if (formKey.currentState.validate()) {
      Map<String,String> userInfoMap={
              "name":usenameTextEditingController.text,
              "email":emailTextEditingController.text
              ,"dp":""
            };
      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
            
        databaseMethods.uploadUserINfo(userInfoMap);
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                                autocorrect: true,
                                validator: (val) {
                                  return val.isEmpty || val.length < 4
                                      ? "ONly usernaem worked"
                                      : null;
                                },
                                controller: usenameTextEditingController,
                                style: simpleTextFieldStyle(),
                                decoration:
                                    textFieldInputDecoraion("UserName")),
                            TextFormField(
                                autocorrect: true,
                                validator: (val) {
                                  return RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(val)
                                      ? null
                                      : "Enter correct email";
                                },
                                controller: emailTextEditingController,
                                style: simpleTextFieldStyle(),
                                decoration: textFieldInputDecoraion("Email")),
                            TextFormField(
                                autocorrect: true,
                                obscureText: true,
                                validator: (val) {
                                  return val.length > 6
                                      ? null
                                      : "6+ character only";
                                },
                                controller: passwordTextEditingController,
                                style: simpleTextFieldStyle(),
                                decoration:
                                    textFieldInputDecoraion("Password")),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                "Forgot Password??",
                                style: simpleTextFieldStyle(),
                              ))),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          signMeUp();
                        },
                        child: Container(
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
                              "Sign up",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            )),
                      ),
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
                            "Sign up With Google",
                            style: TextStyle(color: Colors.black, fontSize: 17),
                          )),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have An account?",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          GestureDetector(
                                  onTap: (){
                                    widget.toggle();
                                  },                    child: Container(
                              padding: EdgeInsets.symmetric(vertical:8),
                              child: Text(
                                "SignIn Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
