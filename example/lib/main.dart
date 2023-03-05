import 'package:chat_app_plugin_example/Screens/Register.dart';
import 'package:chat_app_plugin_example/User.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Users users = Users(dp: "", email: "", password: "", uid: "");
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Register(),
    );
  }
}
