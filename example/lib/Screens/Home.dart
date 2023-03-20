// ignore_for_file: file_names, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:chat_app_plugin/database_service.dart';
import 'package:chat_app_plugin_example/Screens/ChatScree.dart';
import 'package:chat_app_plugin_example/Screens/ChatUser.dart';
import 'package:chat_app_plugin_example/Screens/Search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static String groupname = "";
  Stream? chats;
  Stream? grp;
  static bool chatselected = false;
  getusergroups() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
        .getusergroups()
        .then((snapshot) {
      setState(() {
        chats = snapshot;
      });
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getusergroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 38.0),
                        child: ElevatedButton(
                            onPressed: () {
                              if (!_HomeState.chatselected) {
                                setState(() {
                                  _HomeState.chatselected = true;
                                });
                              }
                            },
                            child: const Text("Chats")),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 38.0),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_HomeState.chatselected) {
                                setState(() {
                                  _HomeState.chatselected = false;
                                });
                              }
                            },
                            child: const Text("Groups")),
                      ),
                    ],
                  ),
                ),
              ),
              _HomeState.chatselected ? chatlist() : grouplist(),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 58.0, right: 58),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            popup(context);
                          },
                          child: const Text("Add Group"),
                        ),
                        const Spacer(),
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Search(),
                              ),
                            );
                          },
                          child: const Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  chatlist() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          // return Text("jhh");
          if (snapshot.data['chatswith'] != null) {
            if (snapshot.data['chatswith'].length != 0) {
              // return
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data['chatswith'].length,
                  // bu: (BuildContext context, int index) =>
                  //     const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      // padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatUser(
                                          user1: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          user2: snapshot.data['chatswith']
                                              [index],
                                          username: snapshot.data['fullname']
                                              [index],
                                          user2name: "sanjay")));
                            },
                            child: Container(
                                color: Colors.blueAccent,
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  snapshot.data['chatswith'][index],
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                )),
                          )
                          // Text(getName(snapshot.data['groups'][index]),
                          // GroupTile(
                          //     groupId: getId(snapshot.data['chatswith'][index]),
                          //     groupName:
                          //         getName(snapshot.data['chatswith'][index]),
                          //     userName: snapshot.data['fullname'])
                        ],
                      ),
                    );
                  },
                ),
                // child: ListView.separated(
                //   itemCount: snapshot.data['groups'].length,
                //   itemBuilder: (context, index) {
                //     int reverseIndex =
                //         snapshot.data['groups'].length - index + 1;
                //     return GroupTile(
                //         groupId: getId(snapshot.data['groups'][reverseIndex]),
                //         groupName:
                //             getName(snapshot.data['groups'][reverseIndex]),
                //         userName: snapshot.data['fullName']);
                //   },
                // ),
              );
            } else {
              return nochat();
            }
          } else {
            return nochat();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  grouplist() {
    return StreamBuilder(
      stream: grp,
      builder: (context, AsyncSnapshot snapshot) {
        // make some checks
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return Expanded(
                child: ListView.separated(
                  itemCount: snapshot.data['groups'].length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Row(
                        children: [
                          // Text(getName(snapshot.data['groups'][index]),
                          GroupTile(
                              groupId: getId(snapshot.data['groups'][index]),
                              groupName:
                                  getName(snapshot.data['groups'][index]),
                              userName: snapshot.data['fullname'])
                        ],
                      ),
                    );
                  },
                ),
                // child: ListView.separated(
                //   itemCount: snapshot.data['groups'].length,
                //   itemBuilder: (context, index) {
                //     int reverseIndex =
                //         snapshot.data['groups'].length - index + 1;
                //     return GroupTile(
                //         groupId: getId(snapshot.data['groups'][reverseIndex]),
                //         groupName:
                //             getName(snapshot.data['groups'][reverseIndex]),
                //         userName: snapshot.data['fullName']);
                //   },
                // ),
              );
            } else {
              return nochat();
            }
          } else {
            return nochat();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        }
      },
    );
  }

  nochat() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 58.0),
        child: Column(
          children: [
            const Text("Sorry You dont have any chat"),
            ElevatedButton(
                onPressed: () {
                  popup(context);
                },
                child: const Text("Create Group"))
          ],
        ),
      ),
    );
  }

  popup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Group"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Enter Group Name"),
              TextFormField(
                onChanged: (value) {
                  _HomeState.groupname = value;
                },
              )
            ],
          ),
          actions: [
            MaterialButton(
              child: const Text("OK"),
              onPressed: () {
                addgroup();
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String userid = FirebaseAuth.instance.currentUser!.uid;

  addgroup() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
        .addgroupwithouticon(FirebaseAuth.instance.currentUser!.uid.toString(),
            "Sanjay", _HomeState.groupname)
        .then((value) => Navigator.of(context).pop());
  }

  GroupTile({required groupId, required groupName, required userName}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
                groupid: groupId, groupname: groupName, user: userName),
          ),
        );
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(50)),
                padding: const EdgeInsets.all(20),
                child: const Text("G"),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  groupName,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getId(data) {
    var arr = data.split('_');
    return arr[0];
  }

  getName(data) {
    var arr = data.split('_');
    return arr[1];
  }
}
