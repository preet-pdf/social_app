import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/views/signIn.dart';
import 'package:social_app/views/signUp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
        primaryColor: Color(0xff145C9E),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SignUp(),
    );
  }
}
