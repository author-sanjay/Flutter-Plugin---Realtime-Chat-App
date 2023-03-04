// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static String userloggedinKey = "";
  static String useremailKey = "";
  static String userNameinKey = "";

  static Future<bool> saveuserstatus(bool status) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userloggedinKey, status);
  }

  static Future<bool> saveuserName(String name) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setString(userNameinKey, name);
  }

  static Future<bool> saveuserEmail(bool email) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(useremailKey, email);
  }

  static Future<bool?> getuserstatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userloggedinKey);
  }

  static Future<String?> getuserName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameinKey);
  }

  static Future<String?> getuserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(useremailKey);
  }
}
