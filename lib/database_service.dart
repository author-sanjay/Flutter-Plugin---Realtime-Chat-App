// ignore_for_file: await_only_futures, unused_local_variable

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
      "uid": uid,
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
      "uid": uid,
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

  finduser(String email) async {
    return usercoll.where("email", isEqualTo: email).get();
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
      "groups": FieldValue.arrayUnion([("${documentReference.id}_$groupname")])
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
      "groups": FieldValue.arrayUnion([("${documentReference.id}_$groupname")])
    });
  }

  Future addreport(String uid, String uidofusertoreport, String messagetoreport,
      String date) async {
    DocumentReference documentrefrence = await report.add({
      "reportedby": uid,
      "reported": uidofusertoreport,
      "messagereported": messagetoreport,
      "date": date
    });
  }

  getgroupchats(String groupid) async {
    return groups
        .doc(groupid)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  getchatchats(String chatid) async {
    return chats.doc(chatid).collection("messages").orderBy("time").snapshots();
  }

  getgroupmembers(String groupid) async {
    return groups.doc(groupid).snapshots();
  }

  Future<bool> isjoined(String uid, String groupid, String groupname) async {
    DocumentReference databaseService = usercoll.doc(uid);
    DocumentSnapshot snapshot = await databaseService.get();

    List<dynamic> groups = await snapshot.get('groups');
    if (groups.contains("${groupid}_$groupname")) {
      return true;
    } else {
      return false;
    }
  }

  Future leavegroup(String uid, String groupid, String groupname) async {
    DocumentReference userdoc = usercoll.doc(uid);
    DocumentReference groupdoc = groups.doc(groupid);
    DocumentSnapshot userdocsnapshot = await userdoc.get();
    DocumentSnapshot groupdocsnapshot = await groupdoc.get();

    List<dynamic> groupss = await userdocsnapshot.get('groups');
    List<dynamic> members = await groupdocsnapshot.get('members');
    if (groupss.contains("${groupid}_$groupname")) {
      await userdoc.update({
        "groups": FieldValue.arrayRemove(["${groupid}_$groupname"])
      });

      await groupdoc.update({
        "members": FieldValue.arrayRemove(["${groupid}_$groupname"])
      });
    }
  }

  addgroupchat(String groupid, Map<String, dynamic> chatmessage) async {
    groups.doc(groupid).collection("messages").add(chatmessage);
    groups.doc(groupid).update({
      "recentmessages": chatmessage['message'],
      "recentsender": chatmessage['sender'],
      "recentmessagetime": chatmessage['time'].toString(),
    });
  }

  addchat(String uid1, String firstusername, String uid2, String secondusername,
      Map<String, dynamic> chatmessage) async {
    DocumentReference user1 = await usercoll.doc(uid1);
    DocumentReference user2 = await usercoll.doc(uid2);
    DocumentSnapshot snap1 = await user1.get();
    DocumentSnapshot snap2 = await user2.get();
    DocumentReference chat1 = await chats.doc(uid1);
    DocumentReference chat2 = await chats.doc(uid2);
    DocumentSnapshot user1Snapshot = await chat1.get();
    DocumentSnapshot user2Snapshot = await chat2.get();
    String chatid = "";
    if (uid1.codeUnitAt(0) < uid2.codeUnitAt(0)) {
      chatid = "${uid1}_$uid2";
    } else {
      chatid = "${uid2}_$uid1";
    }
    List<dynamic> user1chatswith = await snap1.get('chatswith');
    List<dynamic> user2chatswith = await snap2.get('chatswith');
    if (!user1chatswith.contains(uid2)) {
      // user1chatswith.remove("${uid1}_$uid2");
      user1.update({
        "chatswith": FieldValue.arrayUnion([uid2 + "_" + firstusername]),
      });
      user2.update({
        "chatswith": FieldValue.arrayUnion([uid1 + "_" + secondusername]),
      });

      chats.doc(chatid).set({
        "user1": uid1,
        "user2": uid2,
        chatid: chatid,
      });

      chats.doc(chatid).collection("messages").add(chatmessage);
      chats.doc(chatid).update({
        "recentmessages": chatmessage['message'],
        "recentsender": chatmessage['sender'],
        "time": chatmessage['time'].toString(),
      });
    } else {
      chats.doc(chatid).collection("messages").add(chatmessage);
      chats.doc(chatid).update({
        "recentmessages": chatmessage['message'],
        "recentsender": chatmessage['sender'],
        "time": chatmessage['time'].toString(),
      });
    }
  }

  startnewchat(
      String uid, String uid2, Map<String, dynamic> chatmessage) async {
    DocumentReference chatdoc = await chats.add({
      "user1": uid,
      "user2": uid2,
    });

    await chatdoc.update({"chatid": chatdoc.id});

    usercoll.doc(uid).update({
      "chatswith": FieldValue.arrayUnion([uid + "_" + uid2])
    });
    usercoll.doc(uid2).update({
      "chatswith": FieldValue.arrayUnion([uid2 + "_" + uid])
    });

    chats.doc(chatdoc.id).collection("messages").add(chatmessage);
    chats.doc(chatdoc.id).update({
      "recentmessages": chatmessage['message'],
      "recentsender": chatmessage['sender'],
      "recentmessagetime": chatmessage['time'].toString(),
    });
  }

  addnewchatmessage(String chatid, Map<String, dynamic> chat) async {
    chats.doc(chatid).collection("messages").add(chat);
    chats.doc(chatid).update({
      "recentmessages": chat['message'],
      "recentsender": chat['sender'],
      "recentmessagetime": chat['time'].toString(),
    });
  }
}
