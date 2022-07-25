import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_ank_customer/Models/otp_model.dart';
import 'package:new_ank_customer/Models/resent_otp_model.dart';
import 'package:http/http.dart';

class ResendOTPAPIPRovider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  bool _error = false;
  String _errorMessage = "";
  ResentOtpRespones? _resentOtpRespones;

  Future<void> fetchData({required ResentOtpRequest resentOtpRequest}) async {
    final uri = Uri.parse("${baseURL}/api/resend_otp");
    final response = await post(uri, body: resentOtpRequest.toMap());

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _resentOtpRespones = ResentOtpRespones.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _resentOtpRespones = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _resentOtpRespones = null;
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  ResentOtpRespones? get resentOtpRespones => _resentOtpRespones;

  bool get ifLoading => _error == false && _resentOtpRespones == null;
}

class SendOTPAPIPRovider with ChangeNotifier {
  bool _error = false;
  String _errorMessage = "";
  OtpRespones? _otpRespones;

  Future<void> fetchData({required OtpRequest otpRequest}) async {
    final uri = Uri.parse("https://garudayaanlogistics.com/api/send_otp");
    final response = await post(uri, body: otpRequest.toMap());

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _otpRespones = OtpRespones.fromJson(jsonResponse);
      } catch (e) {
        _error = false;
        _errorMessage = e.toString();
        _otpRespones = null;
      }
    } else {
      _error = false;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _otpRespones = null;
    }
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  OtpRespones? get resentOtpRespones => _otpRespones;

  bool get ifLoading => _error == false && _otpRespones == null;
}
