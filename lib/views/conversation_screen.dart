import 'package:flutter/material.dart';
import 'package:social_app/helper/constants.dart';
import 'package:social_app/services/database.dart';
import 'package:social_app/widgets/widgets.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageEditingController = new TextEditingController();
  DataBaseMethods databaseMethods = new DataBaseMethods();
  Stream chatMessageStream;
  Widget ChatMessageList() {
    return StreamBuilder(
        stream: chatMessageStream,
        builder: (context, snapshot) {
          return snapshot.hasData? ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return MessageTile(snapshot.data.docs[index].data()["message"]);
            },
          ):Container();
        });
  }

  sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageEditingController.text,
        "sendBy": Constants.myName,
        "time":DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      setState(() {
      messageEditingController.text = "";
      });
     }
  }
@override
  void initState() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
          child: Stack(
        children: [
          ChatMessageList(),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Color(0x54FFFFFF),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageEditingController,
                      style: simpleTextFieldStyle(),
                      decoration: InputDecoration(
                          hintText: "Send message to this person...",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                            borderRadius: BorderRadius.circular(40)),
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.send)),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  MessageTile(this.message);
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(message,style:TextStyle(color: Colors.white,fontSize: 18),));
  }
}
