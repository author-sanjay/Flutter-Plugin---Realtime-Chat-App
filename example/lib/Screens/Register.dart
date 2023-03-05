// ignore_for_file: avoid_print, file_names

import 'package:chat_app_plugin/chat_app_plugin.dart';
import 'package:chat_app_plugin/database_service.dart';
import 'package:chat_app_plugin_example/Screens/Login.dart';
import 'package:chat_app_plugin_example/User.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});
  static String name = "";
  static String email = "";
  static String password = "";

  @override
  State<Register> createState() => _RegisterState();
}

// Users users = Users(dp: "", email: "", password: "", uid: "");

class _RegisterState extends State<Register> {
  final _chatAppPlugin = ChatAppPlugin();
  final database = DatabaseService();

  Future register(String name, String email, String password) async {
    try {
      await _chatAppPlugin
          .withoutphotoregisterwithemailpassword(email, password, name)
          .then((value) {});

      // print(uid);
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
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(38.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 28.0, bottom: 30),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const Text("Name"),
                TextFormField(
                  onChanged: (value) {
                    Register.name = value;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text("Email"),
                ),
                TextFormField(
                  onChanged: (value) {
                    Register.email = value;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Text("Password"),
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (value) {
                    Register.password = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ElevatedButton(
                      onPressed: () {
                        register(
                            Register.name, Register.email, Register.password);
                      },
                      child: const Text("Register")),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Login"),
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
