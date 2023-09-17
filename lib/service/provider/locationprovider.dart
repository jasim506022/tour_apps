import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  String? currentAddress;
  Position? currentPosition;

  String get getcurrentAddress => currentAddress!;

  setCurrentAdddress({required String address}) {
    currentAddress = address;
    notifyListeners();
  }

  Position get getcurrentPossition => currentPosition!;

  setCurrentPosition({required Position position}) {
    currentPosition = position;
    notifyListeners();
  }
}
