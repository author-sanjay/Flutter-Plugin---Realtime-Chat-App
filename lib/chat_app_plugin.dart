// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, avoid_print

import 'dart:ffi';

import 'package:chat_app_plugin/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        .hasMatch(val);
  }

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String password = pass.trim();
    if (pass_valid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  //add user
  Future withphotoregisterwithemailpassword(
      String email, String password, String name, String photo) async {
    if (isemail(email) && validatePassword(password)) {
      try {
        User user = (await auth.createUserWithEmailAndPassword(
                email: email, password: password))
            .user!;

        if (user != null) {
          await DatabaseService(uid: user.uid)
              .inituserdatawithphoto(user.uid, name, email, photo);
          return true;
        }
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }

  Future withoutphotoregisterwithemailpassword(
      String email, String password, String name) async {
    if (isemail(email) && validatePassword(password)) {
      try {
        User user = (await auth.createUserWithEmailAndPassword(
                email: email, password: password))
            .user!;

        if (user != null) {
          await DatabaseService(uid: user.uid)
              .inituserdatawithoutphoto(user.uid, name, email);
          return true;
        }
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    }
  }

  Future customregister(
      String email, String profilephoto, String name, String uid) async {
    try {
      DatabaseService(uid: uid)
          .inituserdatawithphoto(uid, name, email, profilephoto);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
  //get chat
  //add chat
  //report chat
  //delete for me chat
  //delete for everyone
}
