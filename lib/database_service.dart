// ignore_for_file: await_only_futures

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

  Future getuserdata(String email) async {
    QuerySnapshot snapshot =
        await usercoll.where("email", isEqualTo: email).get();
    return snapshot;
  }

  getusergroups() async {
    return await usercoll.doc(uid).snapshots();
  }

  Future addgroup(
      String uid, String name, String groupname, String groupicon) async {
    DocumentReference documentReference = await groups.add({
      "groupname": groupname,
      "admin": uid,
      "members": [],
      "groupicon": groupicon,
      "recentmessage": "",
      "groupId": "",
      "recentsender": ""
    });

    await documentReference.update({
      "members": FieldValue.arrayUnion([uid]),
      "groupId": documentReference.id
    });

    DocumentReference documentReference2 = await usercoll.doc(uid);
    return await documentReference2.update({
      "groups": FieldValue.arrayUnion([(documentReference.id)])
    });
  }

  Future addgroupwithouticon(String uid, String name, String groupname) async {
    DocumentReference documentReference = await groups.add({
      "groupname": groupname,
      "admin": uid,
      "members": [],
      "groupicon": "",
      "recentmessage": "",
      "groupId": "",
      "recentsender": ""
    });

    await documentReference.update({
      "members": FieldValue.arrayUnion([uid]),
      "groupId": documentReference.id
    });

    DocumentReference documentReference2 = await usercoll.doc(uid);
    return await documentReference2.update({
      "groups": FieldValue.arrayUnion([(documentReference.id)])
    });
  }
}
