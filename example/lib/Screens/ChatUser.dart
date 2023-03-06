import 'package:chat_app_plugin/database_service.dart';
import 'package:chat_app_plugin_example/Screens/MessafeTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatUser extends StatefulWidget {
  ChatUser(
      {required this.user1,
      required this.user2,
      required this.username,
      required this.user2name,
      super.key});
  String user1;
  String username;
  String user2name;
  String user2;
  static String message = "";

  @override
  State<ChatUser> createState() => _ChatUserState();
}

class _ChatUserState extends State<ChatUser> {
  @override
  void initState() {
    super.initState();
    chatMessages();
  }

  static Stream<QuerySnapshot>? chats;
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // chat messages here
          chatMessageslist(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  controller: messageController,
                  onChanged: (value) {
                    setState(() {
                      ChatUser.message = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Send a message...",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                    border: InputBorder.none,
                  ),
                )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    sendMessage(widget.user1, widget.username, widget.user2,
                        widget.user2name, ChatUser.message);
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.send,
                      color: Colors.white,
                    )),
                  ),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  sendMessage(String user1, String user1name, String user2, String user2name,
      String message) async {
    var chatmessage = {
      "message": message,
      "sender": user1name,
      "time": DateTime.now().millisecondsSinceEpoch
    };
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .addchat(user1, user1name, user2, user2name, chatmessage);
  }

  chatMessages() async {
    String chatid = "";
    if (widget.user1.codeUnitAt(0) < widget.user2.codeUnitAt(0)) {
      chatid = "${widget.user1}_${widget.user2}";
    } else {
      chatid = "${widget.user2}_${widget.user1}";
    }

    DatabaseService().getchatchats(chatid).then((val) {
      setState(() {
        _ChatUserState.chats = val;
      });
    });
  }

  chatMessageslist() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sentByMe:
                          widget.user1 == snapshot.data.docs[index]['sender']);
                },
              )
            : Container();
      },
    );
  }
}
