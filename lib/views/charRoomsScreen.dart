import 'package:flutter/material.dart';
import 'package:social_app/helper/authenticate.dart';
import 'package:social_app/helper/constants.dart';
import 'package:social_app/helper/helperfunctions.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/services/database.dart';
import 'package:social_app/views/conversation_screen.dart';
import 'package:social_app/views/search.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();

  Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                    userName: snapshot.data.docs[index].data()['chatRoomId']
                        .toString()
                        .replaceAll("_", "")
                        .replaceAll(Constants.myName, ""),
                    chatRoomId: snapshot.data.docs[index].data()["chatRoomId"],
                  );
                })
            : Container();
      },
    );
    // return StreamBuilder(
    //     stream: chatRoomStream,
    //     builder: (context, snapshot) {
    //       return ListView.builder(
    //           itemCount: snapshot.data.documents.length,
    //           itemBuilder: (context, index) {
    //             return ChatRoomsTile(
    //                 userName: snapshot.data.documents[index].data['chatroomId']
    //                     .toString()
    //                     .replaceAll("_", "")
    //                     .replaceAll(Constants.myName, ""),
    //                 chatRoomId: snapshot.data.documents[index].data["chatroomId"],
    //               );
    //           });
    //     });
  }

  @override
  void initState() {
    getUserInfogetChats();
    
    super.initState();
  }
getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    dataBaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomStream = value;
        print(
            "we got the data + ${chatRoomStream.toString()} this is name  ${Constants.myName}");
      });
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
      body: Container(
        child:chatRoomList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Searchscreen()));
        },
      ),
    );
  }
}
class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({this.userName,this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(
            chatRoomId,
          )
        ));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                 color: Colors.blue,
                  borderRadius: BorderRadius.circular(30)),
              child: Text(userName.substring(0, 1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            ),
            SizedBox(
              width: 12,
            ),
            Text(userName,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300))
          ],
        ),
      ),
    );
  }
}