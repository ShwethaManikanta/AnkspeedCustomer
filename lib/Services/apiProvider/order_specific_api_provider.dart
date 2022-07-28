import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_ank_customer/Models/order_specific_model.dart';
import 'package:http/http.dart';

class OrderSpecificAPIProvider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  bool _error = false;
  String _errorMessage = "";
  OrderSpecificModel? _orderSpecificModel;

  OrderSpecificModel? get orderSpecificModel => _orderSpecificModel;

  bool get error => _error;

  String get errorMessage => _errorMessage;

  bool get ifLoading => _error == false && _orderSpecificModel == null;

  Future<void> orderSpecifiData(
    String orderId,
  ) async {
    final uri =
        Uri.parse("${baseURL}/index.php/Api_customer/get_spacific_order");
    final response = await post(uri, body: {'order_id': orderId});

    print("Order Specific Driver List ---------" +
        response.statusCode.toString());
    print("Order Specific Driver List History ID ---------" + orderId);

    print("Response Specific Order ---------" + response.body.toString());

    // print("API User ID -------" + ApiServices.userId!);
    // print("Order Specific  Driver List ---------------- " + response.body);

    if (response.statusCode == 200) {
      try {
        print(
            "Order Specific  Driver List ---------------- TRY" + response.body);
        final jsonResponse = jsonDecode(response.body);
        _orderSpecificModel = OrderSpecificModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = e.toString();
        _orderSpecificModel = null;
      }
    } else {
      _error = true;
      _errorMessage =
          "Error with response code " + response.statusCode.toString();
      _orderSpecificModel = null;
    }
    notifyListeners();
  }
}
