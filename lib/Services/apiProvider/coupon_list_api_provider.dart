import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_ank_customer/Models/vehicle_categories_response_model.dart';
import 'package:http/http.dart';

class CouponListAPIProvider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  bool _error = false;
  String _errorMessage = "";
  VehicleCategoriesResponseModel? _vehicleCategoriesResponseModel;

  Future<void> fetchData() async {
    final uri = Uri.parse("${baseURL}/api/coupon_list");
    final response = await get(uri);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _vehicleCategoriesResponseModel =
            VehicleCategoriesResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _vehicleCategoriesResponseModel = null;
      }
    } else {
      _error = false;
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
}
