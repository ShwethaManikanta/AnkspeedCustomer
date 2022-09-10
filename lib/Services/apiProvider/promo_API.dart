import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_ank_customer/Models/promo_price_model.dart';
import 'package:http/http.dart' as http;

class PromoAPIProvider with ChangeNotifier {
  bool _error = false;
  String _errormessage = "";
  PromoPriceModel? _promoPriceModel;

  PromoPriceModel? get promoPriceModel => _promoPriceModel;

  bool get error => _error;
  String get errormessage => _errormessage;

  bool get ifLoading => _promoPriceModel == null && _error == false;

  Future getCategoryList(String price, String code) async {
    final uri = Uri.parse(
        "https://chillkrt.in/ANK_speed/index.php/Api_customer/cart_promocode");
    final response = await http.post(uri, body: {"price": price, "code": code});

    print("Response Category ---- >>>> " + response.statusCode.toString());
    print("Response Category ---- >>>> " + response.body.toString());

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        _promoPriceModel = PromoPriceModel.fromJson(jsonResponse);
        print("------------");

        print("----------------------------------");
      } catch (e) {
        _error = true;
        _errormessage =
            "Error response status code " + response.statusCode.toString();
        _promoPriceModel = null;
        print("------------");
        print("Promo API Execution Failed");
        print("----------------------------------");
      }
    } else {
      _error = true;
      _errormessage =
          "Error response status code " + response.statusCode.toString();
      _promoPriceModel = null;
      print("------------");
      print("_categoryListModel API Execution Failed");
      print("----------------------------------");
    }
    notifyListeners();
  }
}
