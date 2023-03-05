import 'package:chat_app_plugin/database_service.dart';
import 'package:chat_app_plugin_example/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static String groupname = "";
  Stream? chats;
  getusergroups() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
        .getusergroups()
        .then((snapshot) {
      print(snapshot);
      setState(() {
        chats = snapshot;
      });
    });
  }

  @override
  void initState() {
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
              child: Column(
            children: [
              Text("Chats"),
              chatlist(),
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
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return Text("");
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
            Text("Sorry You dont have any chat"),
            ElevatedButton(
                onPressed: () {
                  popup(context);
                },
                child: Text("Create Group"))
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
          title: Text("Add Group"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Enter Group Name"),
              TextFormField(
                onChanged: (value) {
                  _HomeState.groupname = value;
                  print(_HomeState.groupname);
                },
              )
            ],
          ),
          actions: [
            MaterialButton(
              child: Text("OK"),
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
}
