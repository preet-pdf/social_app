import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/services/database.dart';
import 'package:social_app/widgets/widgets.dart';

class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  DataBaseMethods databaseMethods = new DataBaseMethods();

  TextEditingController searchtextEditingController =
      new TextEditingController();
  QuerySnapshot searchSnapshot;
  initiateSearch() {
    databaseMethods
        .getUsersByUserName(searchtextEditingController.text)
        .then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  createChatroomAndConversation(String userName) {
    List<String> users=[userName,myNam];
    databaseMethods.createChatRoom(chatRoomId, chatRoomMap)
  }
  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTile(
                  userName: searchSnapshot.docs[index].data()["name"],
                  email: searchSnapshot.docs[index].data()["email"]);
            })
        : Container();
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: Container(
          child: Column(children: [
            Container(
              color: Colors.white12,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                          controller: searchtextEditingController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Search username...",
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none))),
                  GestureDetector(
                    onTap: () async {
                      initiateSearch();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0x36FFFFFF),
                              const Color(0x0FFFFFFF)
                            ]),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.search,
                          size: 30,
                        )),
                  )
                ],
              ),
            ),
            searchList()
          ]),
        ));
  }
}

class SearchTile extends StatelessWidget {
  final String userName;
  final String email;
  SearchTile({this.userName, this.email});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black45),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: simpleTextFieldStyle(),
            ),
            Text(email, style: simpleTextFieldStyle())
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: () {},
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Text(
                "message",
                style: simpleTextFieldStyle(),
              )),
        )
      ]),
    );
  }
}
