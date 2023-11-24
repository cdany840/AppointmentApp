import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ProviderMap extends ChangeNotifier {
  LatLng _selectedLocation = const LatLng(0, 0);

  LatLng get selectedLocation => _selectedLocation;

  set selectedLocation(LatLng location) {
    _selectedLocation = location;
    notifyListeners();
  }
}

class ProviderControllerMap extends ChangeNotifier {
  GoogleMapController? _currentLocation;

  GoogleMapController? get selectedController => _currentLocation;

  set selectedController(GoogleMapController? location) {
    _currentLocation = location;
    notifyListeners();
  }
}