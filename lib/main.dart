import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/views/RazorPay.dart';
import 'package:social_app/views/University_news.dart';
import 'package:social_app/views/charRoomsScreen.dart';
import 'package:social_app/views/homepage.dart';

import 'helper/authenticate.dart';
import 'helper/helperfunctions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;
  @override
  void initState() {
    getLogedInState();
    // TODO: implement initState
    super.initState();
  }

  getLogedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff213970),
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff210070),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn != null ?  userIsLoggedIn ? HomePageStart() : Authnticate()
          : Container(
        child: Center(
          child: Authnticate(),
        ),
      ),
    );
  }
}
