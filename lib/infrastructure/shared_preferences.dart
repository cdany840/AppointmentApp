import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences prefsSession;
  
  static Future<void> configPrefs() async {
    prefsSession = await SharedPreferences.getInstance();
  }
  
}