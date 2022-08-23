import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_ank_customer/Models/couponmodeel.dart';
import 'package:new_ank_customer/Models/unit_list_model.dart';
import 'package:http/http.dart';

class CouponAPIProvider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  bool _error = false;
  String _errorMessage = "";
  CouponModel? _couponModel;

  CouponModel? get couponModel => _couponModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get ifLoading => _error == false && _couponModel == null;

  Future<void> getCouponList() async {
    final uri = Uri.parse(
        "https://chillkrt.in/ANK_speed/index.php/Api_customer/coupon_list");
    final response = await get(uri);

    print("Coupon ------" + response.body);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _couponModel = CouponModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _couponModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _couponModel = null;
    }
    notifyListeners();
  }
}
