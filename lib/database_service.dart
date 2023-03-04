import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference usercoll =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groups =
      FirebaseFirestore.instance.collection("groups");
  final CollectionReference chats =
      FirebaseFirestore.instance.collection("chats");
  final CollectionReference report =
      FirebaseFirestore.instance.collection("report");

  //update user
  Future inituserdatawithphoto(
      String uid, String name, String email, String photo) async {
    return await usercoll.doc(uid).set({
      "chatswith": [],
      "email": email,
      "fullname": name,
      "groups": [],
      "profilephoto": photo
    });
  }

  Future inituserdatawithoutphoto(String uid, String name, String email) async {
    return await usercoll.doc(uid).set({
      "chatswith": [],
      "email": email,
      "fullname": name,
      "groups": [],
    });
  }
}
