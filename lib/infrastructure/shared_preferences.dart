import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences prefsSession;
  static late SharedPreferences prefsLogin;
  static late SharedPreferences prefsThemeColor;  
  
  static Future<void> configPrefs() async {
    prefsSession = await SharedPreferences.getInstance();
    prefsLogin = await SharedPreferences.getInstance();
    prefsThemeColor = await SharedPreferences.getInstance();
  }
  
}