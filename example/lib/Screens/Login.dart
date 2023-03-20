// ignore_for_file: file_names

import 'package:chat_app_plugin/chat_app_plugin.dart';
import 'package:chat_app_plugin/database_service.dart';
import 'package:chat_app_plugin_example/Screens/Home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static String email = "";
  static String password = "";
  @override
  State<Login> createState() => _LoginState();
}

// Users users = Users(dp: "", email: "", password: "", uid: "");

class _LoginState extends State<Login> {
  final _chatapp = ChatAppPlugin();
  final data = DatabaseService();
  login(String email, String password) async {
    await _chatapp
        .loginwithemailandpassword(email, password)
        .then((value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: MediaQuery.of(context).size.height),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
              children: [
                const Text("Login"),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text("Email"),
                    ),
                    TextFormField(
                      onChanged: (value) {
                        Login.email = value;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text("Password"),
                    ),
                    TextFormField(
                      obscureText: true,
                      onChanged: (value) {
                        Login.password = value;
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      login(Login.email, Login.password);
                    },
                    child: const Text("Login"))
              ],
                ),
              )))),
    );
  }
}
