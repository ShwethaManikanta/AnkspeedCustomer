import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:new_ank_customer/Models/cancel_reason_model.dart';

class CancelReasonAPIProvider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  bool _error = false;
  String _errorMessage = "";
  CancelReasonModel? _cancelReasonModel;

  CancelReasonModel? get cancelReasonModel => _cancelReasonModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get ifLoading => _error == false && _cancelReasonModel == null;

  Future<void> fetchReasonList() async {
    final uri = Uri.parse("${baseURL}/index.php/Api_customer/reason_list");
    final response = await get(uri);

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _cancelReasonModel = CancelReasonModel.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _cancelReasonModel = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _cancelReasonModel = null;
    }
    notifyListeners();
  }
}
