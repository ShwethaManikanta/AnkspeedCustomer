import 'dart:convert';
import 'package:new_ank_customer/Services/api_services.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../../Models/UserModel.dart';

class ProfileViewAPIProvider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  bool _error = false;
  String _errorMessage = "";
  ProfileViewResponseModel? _profileViewResponseModel;

  Future<void> fetchData() async {
    final uri = Uri.parse("${baseURL}/index.php/Api_customer/profile");
    final response = await post(uri, body: {'user_id': ApiServices.userId});

    print("---------------------------");
    print("Fetching profile uri");
    print("---------------------------");

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _profileViewResponseModel =
            ProfileViewResponseModel.fromJson(jsonResponse);
        print("Fetching profile uri success");
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _profileViewResponseModel = null;
        print("Fetching profile uri fail");
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _profileViewResponseModel = null;
      print("Fetching profile uri fail");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  ProfileViewResponseModel? get profileViewResponse =>
      _profileViewResponseModel;

  bool get ifLoading => _error == false && _profileViewResponseModel == null;
}
