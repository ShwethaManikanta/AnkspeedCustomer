import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_ank_customer/Models/vehicle_categories_response_model.dart';
import 'package:new_ank_customer/Services/api_services.dart';
import 'package:http/http.dart';

class VehicleCategoriesAPIProvider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";
  bool _error = false;
  String _errorMessage = "";
  VehicleCategoriesResponseModel? _vehicleCategoriesResponseModel;

  Future<void> fetchData(
      {required double fromLat,
      required double fromLong,
      required String toLat,
      required String toLong,
      required int labourQuantity}) async {
    final uri = Uri.parse("${baseURL}/index.php/Api_customer/get_vehicle_list");
    final response = await post(uri, body: {
      'from_lat': fromLat.toString(),
      'from_long': fromLong.toString(),
      'to_lat': toLat,
      'to_long': toLong,
      'labour_qty': labourQuantity.toString(),
      'user_id': ApiServices.userId
    });

    print("---------get Vechile List" + toLat);
    print("---------get Vechile List" + toLong);

    print("----------- vehicle category response " +
        response.statusCode.toString());

    print("----------- vehicle category response " + response.body.toString());
    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _vehicleCategoriesResponseModel =
            VehicleCategoriesResponseModel.fromJson(jsonResponse);
        print("----------- vehicle category response " +
            _vehicleCategoriesResponseModel!.message!.toString());
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _vehicleCategoriesResponseModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _vehicleCategoriesResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  VehicleCategoriesResponseModel? get vehicleCategoriesResponseModel =>
      _vehicleCategoriesResponseModel;

  bool get ifLoading =>
      _error == false && vehicleCategoriesResponseModel == null;

  initialize() {
    _vehicleCategoriesResponseModel = null;
    _error = false;
    _errorMessage = "";
  }
}
