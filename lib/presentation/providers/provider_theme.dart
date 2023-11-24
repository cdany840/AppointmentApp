import 'package:appointment_app/infrastructure/shared_preferences.dart';
import 'package:flutter/material.dart';

class ProviderTheme extends ChangeNotifier {
  int _colorValue = 2;

  int get colorValue => _colorValue;

  void setColorValue(int value) {
    _colorValue = value;
    Preferences.prefsThemeColor.setInt('color', _colorValue);
    notifyListeners();
  }
}