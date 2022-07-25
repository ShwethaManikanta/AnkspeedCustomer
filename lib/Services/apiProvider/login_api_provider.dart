import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import '../../Models/login_model.dart';

class VerifyUserLoginAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  LoginResponseModel? _loginResponse;

  bool get isLoading => _error == false && _loginResponse == null;

  Future<void> getUser(
      {required String deviceToken,
      required String deviceType,
      required String phoneNumber}) async {
    final uri = Uri.parse(
        "https://chillkrt.in/ANK_speed/index.php/Api_customer/signIn");

    final response = await post(uri, body: {
      'phone_no': phoneNumber,
      'device_token': deviceToken,
      'device_type': deviceType
    });

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse.toString());
        _loginResponse = LoginResponseModel.fromJson(jsonResponse);
        print(_loginResponse!.message!);
        print("------------------");
        print("Login Success");
        print("-------------------------------------");
      } catch (e) {
        _error = true;
        _errorMessage =
            "Status code of response " + response.statusCode.toString();
        _loginResponse = null;
        print("------------------");
        print("Login Failed");
        print("-------------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Status code of response " + response.statusCode.toString();
      _loginResponse = null;
      print("------------------");
      print("Login Failed");
      print("-------------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  LoginResponseModel? get loginResponse => _loginResponse;
}
