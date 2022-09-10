import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_ank_customer/Models/profile_model.dart';
import 'package:http/http.dart';

class ProfileUpdateAPIProvider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  bool _error = false;
  String _errorMessage = "";
  ProfileUpdateResponseModel? _profileUpdateResponseModel;

  Future<void> fetchData(
      {required ProfileUpdateRequestModel profileUpdateRequestModel}) async {
    final uri = Uri.parse("${baseURL}/api/vehicle_categories");
    final response = await post(uri, body: profileUpdateRequestModel.toMap());

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _profileUpdateResponseModel =
            ProfileUpdateResponseModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _profileUpdateResponseModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _profileUpdateResponseModel = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  ProfileUpdateResponseModel? get profileUpdatResponseModel =>
      _profileUpdateResponseModel;

  bool get ifLoading => _error == false && _profileUpdateResponseModel == null;
}
