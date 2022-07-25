import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_ank_customer/Models/vehicle_categories_response_model.dart';
import 'package:new_ank_customer/Services/api_services.dart';
import 'package:http/http.dart';

import '../../Models/helper_list_model.dart';

class HelperListAPIProvider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  bool _error = false;
  String _errorMessage = "";
  HelperListResponseModel? _helperListResponseModel;

  Future<void> fetchData() async {
    final uri = Uri.parse("${baseURL}/index.php/Api_customer/labour_list");
    final response = await post(uri, body: {'user_id': ApiServices.userId});

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _helperListResponseModel =
            HelperListResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _helperListResponseModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _helperListResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  HelperListResponseModel? get helperListResponseModel =>
      _helperListResponseModel;

  bool get ifLoading => _error == false && _helperListResponseModel == null;
}
