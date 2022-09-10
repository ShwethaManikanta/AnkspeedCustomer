// ignore_for_file: unnecessary_brace_in_string_interps
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'location_helper.dart';

enum InitializeSharedPreference { initialize, uninitialize }

SelectedSourceDestinationLongitudeLatitude selectedLongLat =
    SelectedSourceDestinationLongitudeLatitude();

class SelectedSourceDestinationLongitudeLatitude {
  static double? _selectedLongitude;
  static double? _selectedLatitude;
  double? get selectedLongitude => _selectedLongitude;
  double? get selectedLatitude => _selectedLatitude;

  setSelectedLongitude(double value) {
    _selectedLongitude = value;
  }

  setSelectedLatitude(double value) {
    _selectedLatitude = value;
  }
}

class SharedPreference with ChangeNotifier {
  static late LocationHelper locationHelper;
  static double? latitudeValue;
  static double? longitudeValue;
  static double? selectedLongitude;
  static double? selectedLatitude;
  static String? devicetoken;
  static double? latitude;
  static double? longitude;
  static String? address;
  static String? currentAddress;
  static late SharedPreferences sharedPreference;
  static InitializeSharedPreference initializeSharedPreference =
      InitializeSharedPreference.uninitialize;

  static Future<void> getLocationData(dynamic lat, dynamic long) async {
    if (locationHelper.longitude == null || locationHelper.latitude == null) {
      print("data not fetched!");
    } else {
      latitude = lat;
      longitude = long;
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude!, longitude!);

      Placemark place = placemarks[0];
      currentAddress =
          "${place.street} ${place.subLocality},${place.locality},${place.subAdministrativeArea}";
      address =
          "${place.street} ${place.subLocality},${place.locality},${place.subAdministrativeArea}";

      print("Shared address ------" + address.toString());
    }
  }

  static Future<void> setValues() async {
    locationHelper = LocationHelper();
    await locationHelper.getCurrentLocation();
    await getLocationData(locationHelper.latitude, locationHelper.longitude)
        .then((value) async {
      sharedPreference = await SharedPreferences.getInstance();
      sharedPreference.setDouble("LATITUDE", latitude ?? 27.2046);
      sharedPreference.setDouble("LONGITUDE", longitude ?? 77.4977);
      sharedPreference.setString("ADDRESS", currentAddress ?? "NA");
    });
    await getValues();
    initializeSharedPreference = InitializeSharedPreference.initialize;
  }

  static Future<void> getValues() async {
    sharedPreference = await SharedPreferences.getInstance();
    latitudeValue = sharedPreference.getDouble("LATITUDE") ?? 27.2046;
    longitudeValue = sharedPreference.getDouble("LONGITUDE") ?? 77.4977;
    address = sharedPreference.getString("ADDRESS") ?? "NA";
    print(
        "value get in share pref +${latitudeValue} ${longitudeValue} ${address}");
  }
}

class LocationSharedPreference with ChangeNotifier {
  late LocationHelper locationHelper;
  dynamic latitudeValue;
  dynamic longitudeValue;
  dynamic devicetoken;
  dynamic latitude;
  dynamic longitude;
  dynamic address;
  dynamic currentAddress;
  late SharedPreferences sharedPreference;
  InitializeSharedPreference initializeSharedPreference =
      InitializeSharedPreference.uninitialize;

  Future<void> getLocationData(dynamic lat, dynamic long) async {
    locationHelper = LocationHelper();

    await locationHelper.getCurrentLocation();
    if (locationHelper.longitude == null || locationHelper.latitude == null) {
      print("data not fetched!");
    } else {
      latitude = lat;
      longitude = long;
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      Placemark place = placemarks[0];

      currentAddress =
          "${place.street} ${place.subLocality},${place.locality},${place.subAdministrativeArea}";
    }
  }

  Future<void> setValues() async {
    locationHelper = LocationHelper();

    await locationHelper.getCurrentLocation();
    await getLocationData(locationHelper.latitude, locationHelper.longitude)
        .then((value) async {
      sharedPreference = await SharedPreferences.getInstance();
      sharedPreference.setDouble("LATITUDE", latitude ?? 27.2046);
      sharedPreference.setDouble("LONGITUDE", longitude ?? 77.4977);
      sharedPreference.setString("ADDRESS", currentAddress ?? "NA");
    });
    await getValues();

    initializeSharedPreference = InitializeSharedPreference.initialize;
  }

  Future<void> getValues() async {
    sharedPreference = await SharedPreferences.getInstance();
    latitudeValue = sharedPreference.getDouble("LATITUDE") ?? 27.2046;
    longitudeValue = sharedPreference.getDouble("LONGITUDE") ?? 77.4977;
    address = sharedPreference.getString("ADDRESS") ?? "NA";
    print(
        "value get in share pref +${latitudeValue} ${longitudeValue} ${address}");
  }
}
