import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_ank_customer/Models/near_driver_list_model.dart';
import 'package:http/http.dart';

class NearbyDriverListAPIProvider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  bool _error = false;
  String _errorMessage = "";
  NearByDriverListModel? _nearByDriverListModel;

  NearByDriverListModel? get nearByDriverListModel => _nearByDriverListModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get ifLoading => _error == false && _nearByDriverListModel == null;

  Future<void> nearByDriverList(
      String fromLat, String fromLng, String vehicleId, String type) async {
    final uri = Uri.parse("${baseURL}/index.php/Api_customer/near_driver_list");
    final response = await post(uri, body: {
      'from_lat': fromLat,
      'from_lng': fromLng,
      'vehicle_id': vehicleId,
      'type': type
    });

    print("Near Driver List ---------" + response.statusCode.toString());

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _nearByDriverListModel = NearByDriverListModel.fromJson(jsonResponse);
        print("Near Driver List ---------------- TRY" + response.body);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _nearByDriverListModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _nearByDriverListModel = null;
    }
    notifyListeners();
  }
}
