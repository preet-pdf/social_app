import 'package:flutter/material.dart';
import 'package:social_app/helper/helperfunctions.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/services/database.dart';
import 'package:social_app/views/charRoomsScreen.dart';
import 'package:social_app/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods = new AuthMethods();
  QuerySnapshot snapshotuserinfo;
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();
  bool isLoading = false;
  signmein() async {


    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authMethods
          .signInWithEmailAndPassword(
              emailTextEditingController.text, passwordTextEditingController.text)
          .then((result) async {
        if (result != null)  {
          QuerySnapshot userInfoSnapshot =
              await dataBaseMethods.getUsersByEmail(emailTextEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.docs[0].data()["name"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.docs[0].data()["email"]);
          print("${userInfoSnapshot.docs[0].data()["name"]}");
          print("${userInfoSnapshot.docs[0].data()["email"]}");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePageStart()));
        } else {
          setState(() {
            isLoading = false;
            //show snackbar
          });
        }
      });
    }

    // HelperFunctions.saveUserEmailSharedPreference(
    //     emailTextEditingController.text);
    // //HelperFunctions.saveUserNameSharedPreference( usenameTextEditingController.text);
    // setState(() {
    //   isLoading = true;
    // });
    // dataBaseMethods.getUsersByEmail(emailTextEditingController.text).then((value){
    //   snapshotuserinfo=value;
    //   HelperFunctions.saveUserEmailSharedPreference(snapshotuserinfo.docs[0].data()["name"]);
    // });

    // authMethods
    //     .signInWithEmailAndPassword(
    //         emailTextEditingController.text, passwordTextEditingController.text)
    //     .then((value) {
    //   if (value != null) {
    //     HelperFunctions.saveUserLoggedInSharedPreference(true);
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => ChatRoom()));
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
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
                            return val.length > 6 ? null : "6+ character only";
                          },
                          controller: passwordTextEditingController,
                          style: simpleTextFieldStyle(),
                          decoration: textFieldInputDecoraion("Password")),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text(
                          "Forgot Password??",
                          style: simpleTextFieldStyle(),
                        ))),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    signmein();
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(colors: [
                            const Color(0xff210070),
                            const Color(0xff2A75BC)
                          ])),
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 17),
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
                        padding: EdgeInsets.symmetric(vertical: 8),
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
