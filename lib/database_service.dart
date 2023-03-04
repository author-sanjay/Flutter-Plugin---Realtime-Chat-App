import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  static final CollectionReference usercoll =
      FirebaseFirestore.instance.collection("users");
  static final CollectionReference groups =
      FirebaseFirestore.instance.collection("groups");
  static final CollectionReference chats =
      FirebaseFirestore.instance.collection("chats");
  static final CollectionReference report =
      FirebaseFirestore.instance.collection("report");

  //update user
  static Future inituserdata(String uid, String name, String email,
      String password, String photo) async {
    return await usercoll.doc(uid).set({
      "chatswith": [],
      "email": email,
      "fullname": name,
      "groups": [],
      "profilephoto": photo
    });
  }
}
