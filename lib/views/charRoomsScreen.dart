import 'package:flutter/material.dart';
import 'package:social_app/helper/authenticate.dart';
import 'package:social_app/helper/constants.dart';
import 'package:social_app/helper/helperfunctions.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/views/search.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  @override
  void initState() {
    getUserInfo();
        super.initState();
  }
  getUserInfo() async {
     Constants.myName=await HelperFunctions.getUserNameSharedPreference();
    setState(() {
      
    });
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CharuSocial"),
        actions: [
          GestureDetector(
            onTap: () {
               HelperFunctions.saveUserLoggedInSharedPreference(false);
              authMethods.signOut();
              
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authnticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app_outlined)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Searchscreen()));
        },
      ),
    );
  }
}
