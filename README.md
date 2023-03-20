# Flutter Realtime Chat App Plugin 📱💬

A Flutter plugin for building a realtime chat application. This plugin provides an easy-to-use API for developers to implement a chat feature into their Flutter app.

## Features ✨

- Realtime messaging: Send and receive messages in real-time 🚀
- Push notifications: Receive push notifications for new messages 📩
- User authentication: Authenticate users with your own backend service 🔒
- Image support: Send and receive images in chats 📷
- Group chat: Create group chats and chat with multiple users at once 👥
- Typing indicators: See when users are typing in a chat ⌨️
- Read receipts: See when a user has read a message 👀
- Customizable UI: Customize the look and feel of the chat interface to match your app's branding 🎨

## Installation
<<<<<<< HEAD
=======
    `flutter pub add chat_app_plugin`

## Database Functions
- `inituserdatawithphoto(String uid, String name, String email, String photo)`

- `Future inituserdatawithoutphoto(String uid, String name, String email)`

- `Future getuserdata(String email) `

- `finduser(String email)`

- `getusergroups() `

- `Future addgroup(String uid, String name, String groupname, String groupicon)`

- `Future addgroupwithouticon(String uid, String name, String groupname)`

- `Future addreport(String uid, String uidofusertoreport, String messagetoreport,String date) `

- `getgroupchats(String groupid) `

- `getchatchats(String chatid)`

- `getgroupmembers(String groupid)`

- `Future<bool> isjoined(String uid, String groupid, String groupname)`

- `Future leavegroup(String uid, String groupid, String groupname)`

- `addgroupchat(String groupid, Map<String, dynamic> chatmessage)`

- `addchat(String uid1, String firstusername, String uid2, String secondusername,Map<String, dynamic> chatmessage)`

- `startnewchat(String uid, String uid2, Map<String, dynamic> chatmessage) `

- `addnewchatmessage(String chatid, Map<String, dynamic> chat)`


- `Future withphotoregisterwithemailpassword(
      String email, String password, String name, String photo)`
   
 - ` Future<String?> tokenwithphotoregisterwithemailpassword(
      String email, String password, String name, String photo) `


 - ` Future withoutphotoregisterwithemailpassword(
      String email, String password, String name) `


  - `Future<String?> tokenwithoutphotoregisterwithemailpassword(
      String email, String password, String name)`


  - `Future customregister(
      String email, String profilephoto, String name, String uid)`


- `Future loginwithemailandpassword(String email, String password)`


  - `Future<String?> tokenloginwithemailpassword(String email, password)` 
  - `Future<String?> tokenloginwithphonenumber(String phonenumber)`
  - `Future loginwithphonenumber(String phonenumber)`
  - `Future signout()`
  - `Future sendforgotpassword(String email)`
  - `Future addgroup(String uid, String adminname, String groupname, String groupicon)`     
  - `Future addgroupwithouticon(
      String uid, String adminname, String groupname)`





>>>>>>> 34585c44dcdcca198a519201081c2b8eee6b9151

    `flutter pub add chat_app_plugin`

## Database Functions

- `inituserdatawithphoto(String uid, String name, String email, String photo)`

- `Future inituserdatawithoutphoto(String uid, String name, String email)`

- `Future getuserdata(String email) `

- `finduser(String email)`

- `getusergroups() `

- `Future addgroup(String uid, String name, String groupname, String groupicon)`

- `Future addgroupwithouticon(String uid, String name, String groupname)`

- `Future addreport(String uid, String uidofusertoreport, String messagetoreport,String date) `

- `getgroupchats(String groupid) `

- `getchatchats(String chatid)`

- `getgroupmembers(String groupid)`

- `Future<bool> isjoined(String uid, String groupid, String groupname)`

- `Future leavegroup(String uid, String groupid, String groupname)`

- `addgroupchat(String groupid, Map<String, dynamic> chatmessage)`

- `addchat(String uid1, String firstusername, String uid2, String secondusername,Map<String, dynamic> chatmessage)`

- `startnewchat(String uid, String uid2, Map<String, dynamic> chatmessage) `

- `addnewchatmessage(String chatid, Map<String, dynamic> chat)`

- `Future withphotoregisterwithemailpassword(
    String email, String password, String name, String photo)`
- `Future<String?> tokenwithphotoregisterwithemailpassword(
   String email, String password, String name, String photo)`

- `Future withoutphotoregisterwithemailpassword(
   String email, String password, String name)`

- `Future<String?> tokenwithoutphotoregisterwithemailpassword(
  String email, String password, String name)`

- `Future customregister(
  String email, String profilephoto, String name, String uid)`

- `Future loginwithemailandpassword(String email, String password)`

  - `Future<String?> tokenloginwithemailpassword(String email, password)`
  - `Future<String?> tokenloginwithphonenumber(String phonenumber)`
  - `Future loginwithphonenumber(String phonenumber)`
  - `Future signout()`
  - `Future sendforgotpassword(String email)`
  - `Future addgroup(String uid, String adminname, String groupname, String groupicon)`
  - `Future addgroupwithouticon(
  String uid, String adminname, String groupname)`
