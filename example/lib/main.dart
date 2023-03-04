import 'package:chat_app_plugin/database_service.dart';
import 'package:chat_app_plugin_example/Screens/Login.dart';
import 'package:chat_app_plugin_example/Screens/Register.dart';
import 'package:chat_app_plugin_example/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Register(),
    );
  }
}
