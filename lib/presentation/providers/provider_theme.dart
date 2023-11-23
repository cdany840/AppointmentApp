import 'package:appointment_app/config/theme/app_theme.dart';
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

class ProviderThemeColor with ChangeNotifier {
  ThemeData _currentTheme = AppTheme( selectedColor: 2, fontFamily: 'Lato' ).theme( Brightness.light );

  ThemeData get currentTheme => _currentTheme;

  void updateTheme(int color) {
    _currentTheme = AppTheme( selectedColor: color, fontFamily: 'Lato' ).theme( Brightness.light );
    notifyListeners();
  }
}