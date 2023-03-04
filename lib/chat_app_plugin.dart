import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'chat_app_plugin_platform_interface.dart';

class ChatAppPlugin {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<String?> getPlatformVersion() {
    return ChatAppPluginPlatform.instance.getPlatformVersion();
  }

  //checkisemail

  static bool isemail(String val) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val!);
  }

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (pass_valid.hasMatch(_password)) {
      return true;
    } else {
      return false;
    }
  }

  //add user
  Future registerwithemailpassword(
      String email, String password, String name) async {
    if (isemail(email) && validatePassword(password)) {
      try {
        User user = (await auth.createUserWithEmailAndPassword(
                email: email, password: password))
            .user!;
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }
  //get chat
  //add chat
  //report chat
  //delete for me chat
  //delete for everyone
}
