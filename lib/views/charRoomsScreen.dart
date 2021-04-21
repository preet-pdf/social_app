import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:social_app/helper/authenticate.dart';
import 'package:social_app/helper/constants.dart';
import 'package:social_app/helper/helperfunctions.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/services/database.dart';
import 'package:social_app/views/MapView2.dart';
import 'package:social_app/views/RazorPay.dart';
import 'package:social_app/views/University_news.dart';
import 'package:social_app/views/conversation_screen.dart';
import 'package:social_app/views/create_blog.dart';
import 'package:social_app/views/homepage.dart';
import 'package:social_app/views/search.dart';
class HomePageStart extends StatefulWidget {
  @override
  _HomePageStartState createState() => _HomePageStartState();
}

class _HomePageStartState extends State<HomePageStart> {
  int pageIndex = 0;
  final  ChatRoom _listproduct = ChatRoom();
  final HomePage _listproduct1 = HomePage();
  final LoadDataFromFirestore _listproduct2 = LoadDataFromFirestore();
  final MapView2 _listproduct3 = MapView2();
  final rpay _listproduct4 = rpay();
  Widget _showPage = new ChatRoom();
  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _listproduct;
        break;
      case 1:
        
        return _listproduct1;
        break;
      case 2:
        return _listproduct2;
        break;
      case 3:
        return _listproduct3;
        break;
      case 4:
        return _listproduct4;
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text("Owner ko kaho data dale"),
          ),
        );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showPage,
bottomNavigationBar: CurvedNavigationBar(
        index: pageIndex,
        color: Colors.blue,
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.people,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.all_inclusive,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.list,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (int tappedIndex) {
          print(tappedIndex.toString());
          setState(() {
            _showPage = _pageChooser(tappedIndex);
          });
        })
    );
  }
}
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
backgroundColor: Colors.black26,
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
       // color: Colors.black26,
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