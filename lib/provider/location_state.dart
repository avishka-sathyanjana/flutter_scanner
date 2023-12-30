import 'package:flutter/material.dart';
import '/model_data/LocationCode.dart';

class LocationProvider extends ChangeNotifier{

  LocationCode _locationCode=LocationCode(locationCode: '');
  String get location=>_locationCode.locationCode;

  void updateLocation(String newLocation) {
    _locationCode= LocationCode(locationCode:newLocation);
    notifyListeners();
  }
}