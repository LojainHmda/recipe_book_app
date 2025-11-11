import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPreferences {
  static late final SharedPreferences prefs;
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setSharedPreferences(String uid) async {
    await prefs.setString("uid", uid);
  }

  static Future<String?> getSharedPreferences() async {
    return await prefs.getString("uid");
  }

  static Future<void> removeSharedPreferences() async {
    await prefs.remove("uid");
  }
}
