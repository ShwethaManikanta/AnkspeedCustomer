import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_ank_customer/Models/book_vehicle_models.dart';
import 'package:http/http.dart';

class BookVehicleAPIProvider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  bool _error = false;
  String _errorMessage = "";
  BookVehicleResponseModel? _bookVehicleResponseModel;

  Future<void> fetchData(
      {required BookVehicleRequestModel bookVehicleRequestModel}) async {
    final uri = Uri.parse("${baseURL}/index.php/Api_customer/book_vehicle");
    final response = await post(uri, body: bookVehicleRequestModel.toMap());

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _bookVehicleResponseModel =
            BookVehicleResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _bookVehicleResponseModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _bookVehicleResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  BookVehicleResponseModel? get vehicleCategoriesResponseModel =>
      _bookVehicleResponseModel;

  bool get ifLoading =>
      _error == false && vehicleCategoriesResponseModel == null;
}
