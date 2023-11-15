import 'package:flutter/material.dart';

class ProviderDropdown extends ChangeNotifier {
  String _dropdownValue = '';

  String get dropdownValue => _dropdownValue;

  set dropdownValue(String value) {
    _dropdownValue = value;
    notifyListeners();
  }

}