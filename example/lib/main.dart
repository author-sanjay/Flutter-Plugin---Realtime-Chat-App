import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:chat_app_plugin/chat_app_plugin.dart';
import 'apis.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "Chatapp",
      options: const FirebaseOptions(
          apiKey: apiss.akey,
          appId: apiss.appId,
          messagingSenderId: apiss.messagesender,
          projectId: apiss.projectid));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static String name = "";
  static String email = "";
  static String password = "";

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _chatAppPlugin = ChatAppPlugin();

  Future register(String name, String email, String password) async {
    try {
      await _chatAppPlugin.withoutphotoregisterwithemailpassword(
          email, password, name);

      
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 28.0, bottom: 30),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Text("Name"),
              TextFormField(
                onChanged: (value) {
                  MyApp.name = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Email"),
              ),
              TextFormField(
                onChanged: (value) {
                  MyApp.email = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Password"),
              ),
              TextFormField(
                obscureText: true,
                onChanged: (value) {
                  MyApp.password = value;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ElevatedButton(
                    onPressed: () {
                      register(MyApp.name, MyApp.email, MyApp.password);
                    },
                    child: Text("Register")),
              )
            ],
          ),
        )),
      ),
    );
  }
}
