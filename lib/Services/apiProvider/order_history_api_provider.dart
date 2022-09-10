import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_ank_customer/Models/order_history_model.dart';
import 'package:new_ank_customer/Services/api_services.dart';
import 'package:http/http.dart';
import '../../Models/login_model.dart';

class OrderHistoryAPIProvider with ChangeNotifier {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  bool _error = false;
  String _errorMessage = "";
  OrderHistoryModel? _orderHistoryModel;

  bool get ifLoading => _error == false && _orderHistoryModel == null;

  Future<void> getOrders() async {
    final uri = Uri.parse("${baseURL}/index.php/Api_customer/order_history");

    final response = await post(uri, body: {'user_id': ApiServices.userId});

    if (response.statusCode == 200) {
      try {
        final jsonResponse = jsonDecode(response.body);
        // print(jsonResponse.toString());
        _orderHistoryModel = OrderHistoryModel.fromJson(jsonResponse);
      } catch (e) {
        _error = true;
        _errorMessage = "Status code of response " + e.toString();
        _orderHistoryModel = null;
        // print("------------------");
        // print("Order History Fetching  Failed");
        // print("-------------------------------------");
      }
    } else {
      _error = true;
      _errorMessage =
          "Status code of response " + response.statusCode.toString();
      _orderHistoryModel = null;
      // print("------------------");
      // print("Order History Fetching  Failed");
      // print("-------------------------------------");
    }
    notifyListeners();
  }

  bool get error => _error;

  String get errorMessage => _errorMessage;

  OrderHistoryModel? get orderHistoryResponse => _orderHistoryModel;
}
