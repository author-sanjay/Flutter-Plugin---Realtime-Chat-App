import 'package:chat_app_plugin/chat_app_plugin.dart';
import 'package:chat_app_plugin/database_service.dart';
import 'package:chat_app_plugin_example/Screens/ChatUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  static String searchuser = "";
  static QuerySnapshot? userss;
  static bool searched = false;
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final chatapp = ChatAppPlugin();
    final data = DatabaseService();
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Text("search"),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text("Search"),
                        ),
                        TextFormField(
                          onChanged: (value) {
                            Search.searchuser = value;
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        search(Search.searchuser);

                        // login(Login.email, Login.password);
                      },
                      child: Text("search"),
                    ),
                    Search.searched ? userss() : Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  search(String searchuser) async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
        .finduser(searchuser)
        .then((snapshot) {
      setState(() {
        Search.userss = snapshot;
        print("object");
        Search.searched = true;
      });
    });
  }

  userss() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: Search.userss!.docs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatUser(
                    user1: FirebaseAuth.instance.currentUser!.uid,
                    username: "sanju",
                    user2: Search.userss!.docs[index]['uid'],
                    user2name: Search.userss!.docs[index]['fullname'],
                  ),
                ),
              );
            },
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                color: Colors.deepPurple,
                child: Text(
                  Search.userss!.docs[index]['fullname'],
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
          );
          // return groupTile(
          //   userName,
          //   searchSnapshot!.docs[index]['groupId'],
          //   searchSnapshot!.docs[index]['groupName'],
          //   searchSnapshot!.docs[index]['admin'],
          // );
        });
  }
}
