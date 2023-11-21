import 'package:flutter/material.dart';

const _customColor = Color( 0xFF49149F );

const List<Color> _colorTheme = [
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
  Colors.lightBlue,
  // ? Juan's Colors
  Color.fromARGB(255, 51, 51, 51),
  Color.fromARGB(255, 245, 245, 245),
  Color.fromARGB(255, 64, 112, 112),
  Color.fromARGB(255, 64, 103, 76),
  Color.fromARGB(255, 191, 211, 244),
];

class AppTheme {
  
  final int selectedColor;
  final String? fontFamily;

  AppTheme({
    this.selectedColor = 0,
    this.fontFamily
  }): assert(
    selectedColor >= 0 && selectedColor <= _colorTheme.length - 1, 
    'Colors must be between 0 and ${ _colorTheme.length }'
  );

  ThemeData theme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      fontFamily: fontFamily,
      // colorSchemeSeed: _colorTheme[selectedColor],
      colorScheme: ColorScheme.fromSeed(
        seedColor: _colorTheme[selectedColor],
        brightness: brightness,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: _colorTheme[selectedColor],
        elevation: 10,
        shadowColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.black
        )
      ),
      textTheme: const TextTheme(
        headlineSmall: const TextStyle(fontSize: 18.0),
        headlineMedium: const TextStyle(fontSize: 24.0),
        headlineLarge: const TextStyle(fontSize: 28.0),
      )
    );
  }

}