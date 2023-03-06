// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, avoid_print

import 'package:chat_app_plugin/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatAppPlugin {
  final FirebaseAuth auth = FirebaseAuth.instance;

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

  //add user with photo

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
    } else {
      throw "Password or email not of right type";
    }
    return false;
  }

  Future<String?> tokenwithphotoregisterwithemailpassword(
      String email, String password, String name, String photo) async {
    if (isemail(email) && validatePassword(password)) {
      try {
        User user = (await auth.createUserWithEmailAndPassword(
                email: email, password: password))
            .user!;

        if (user != null) {
          await DatabaseService(uid: user.uid)
              .inituserdatawithphoto(user.uid, name, email, photo);
          return user.getIdToken();
        }
      } on FirebaseAuthException catch (e) {
        print(e);
      }
    } else {
      throw "Password or email not of right type";
    }
    return null;
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
        // return e;
      }
    }

    return false;
  }

  Future<String?> tokenwithoutphotoregisterwithemailpassword(
      String email, String password, String name) async {
    if (isemail(email) && validatePassword(password)) {
      try {
        User user = (await auth.createUserWithEmailAndPassword(
                email: email, password: password))
            .user!;

        if (user != null) {
          await DatabaseService(uid: user.uid)
              .inituserdatawithoutphoto(user.uid, name, email);
          return user.getIdToken();
        }
      } on FirebaseAuthException catch (e) {
        print(e);
        // return e;
      }
    }

    return null;
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

  Future loginwithemailandpassword(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        return true;
      });
      // if()
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<String?> tokenloginwithemailpassword(String email, password) async {
    try {
      User user = await auth.signInWithEmailAndPassword(
          email: email, password: password) as User;
      if (user != null) {
        return user.getIdToken();
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    return null;
  }

  Future<String?> tokenloginwithphonenumber(String phonenumber) async {
    try {
      User user = await auth.signInWithPhoneNumber(phonenumber) as User;
      if (user != null) {
        return user.refreshToken;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    return null;
  }

  Future loginwithphonenumber(String phonenumber) async {
    try {
      User user = await auth.signInWithPhoneNumber(phonenumber) as User;
      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    return false;
  }

  Future signout() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
    }

    return null;
  }

  Future sendforgotpassword(String email) async {
    try {
      auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
    }

    return false;
  }

//add groups
  Future addgroup(
      String uid, String adminname, String groupname, String groupicon) async {
    try {
      DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
          .addgroup(uid, adminname, groupname, groupicon);

      return true;
    } catch (e) {
      print(e);
    }
  }

  Future addgroupwithouticon(
      String uid, String adminname, String groupname) async {
    try {
      DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
          .addgroupwithouticon(uid, adminname, groupname);

      return true;
    } catch (e) {
      print(e);
    }
  }

  // Future getchat(String chatid) async {
  //   try {
  //     DatabaseService(uid: FirebaseAuth.instance.currentUser?.uid)
  //         .getchat(chatid);
  //   } catch (e) {}
  // }

//get user data

  //get chat

  //add chat
  //report chat
  //delete for me chat
  //delete for everyone
}
