import 'package:flutter/material.dart';

class ProviderDropdown extends ChangeNotifier {
  String _dropdownValue = '';

  String get dropdownValue => _dropdownValue;

  set dropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }
}

class ProviderInputTime extends ChangeNotifier {
  TimeOfDay _selectedTime = const TimeOfDay( hour: 0, minute: 10 );

  TimeOfDay get selectedTime => _selectedTime;

  set selectedTime(TimeOfDay time) {
    _selectedTime = time;
    notifyListeners();
  }
}

class ProviderScreenProfile extends ChangeNotifier {
  bool _screen = true;

  bool get screen => _screen;

  set screen(bool value) {
    _screen = value;
    notifyListeners();
  }
}