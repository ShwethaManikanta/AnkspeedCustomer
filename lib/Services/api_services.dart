import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_ank_customer/Models/login_model.dart';
import 'package:new_ank_customer/Models/order_track_model.dart';
import 'package:new_ank_customer/Models/otp_model.dart';
import 'package:new_ank_customer/Models/profile_model.dart';
import 'package:new_ank_customer/Models/profile_view_model.dart';
import 'package:new_ank_customer/Models/resent_otp_model.dart';
import 'package:http/http.dart';

ApiServices apiServices = ApiServices();

class ApiServices {
  final String baseURL = "https://chillkrt.in/ANK_speed";

  static String? userId;

  Future<bool> updateProfile(
      {String userName = "",
      String userPhoneNumber = "",
      String userEmail = ""}) async {
    final url = Uri.parse("${baseURL}/index.php/Api_customer/profile_update");
    Response response = await post(url, body: {
      'user_id': userId,
      'mobile': userPhoneNumber,
      'user_name': userName,
      'email': userEmail
    });
    if (response.statusCode == 200) {
      try {
        print("Update response " + response.body.toString());
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status'] == "1") {
          return true;
        }
      } catch (e) {
        print(e.toString());
        return false;
      }
      return true;
    } else {
      return false;
    }
  }
  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

  Future<ProfileRespones?> profile(ProfileRequesst profileRequesst) async {
    String url =
        "https://goeasydocabs.com/logistics/admin_new/api/profile_update";
    var postUri = Uri.parse(url);
    var request = new MultipartRequest("POST", postUri);
    request.fields['name'] = profileRequesst.name;
    request.fields['email'] = profileRequesst.email;
    request.fields['user_id'] = profileRequesst.userid;
    request.files.add(
      await MultipartFile.fromPath(
        'file_name',
        profileRequesst.filename,
      ),
    );
    StreamedResponse response = await request.send();
    String value = await response.stream.bytesToString();
    print(value);
    var jsonResponse = jsonDecode(value);
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        textColor: Colors.green.shade900,
        backgroundColor: Colors.white,
        msg: jsonResponse['message']);
    ProfileRespones? profileRespones;
    if (jsonResponse['errorCode'] == "200") {
      profileRespones = ProfileRespones.fromMap(jsonResponse['message']);
    }
    return profileRespones;
  }

  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

  Future<OrderTrackModel?> trackOrder({required String orderId}) async {
    String url = "${baseURL}/index.php/Api_customer/track_details";
    var postUri = Uri.parse(url);
    final response = await post(postUri, body: {"order_id": orderId});
    print(response.body);
    var jsonResponse = jsonDecode(response.body);

    final orderTrackModel = OrderTrackModel.fromJson(jsonResponse);

    return orderTrackModel;
  }

  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
  Future<OrderAcceptRejectResponse?> cancelOrder(
      {required String orderId, String? reasonID, String? reasonText}) async {
    var url = Uri.parse('${baseURL}/index.php/Api_customer/cancel_order');
    Response response = await post(url, body: {
      'order_id': orderId,
      'cancel_reason_id': reasonID,
      'cancel_reason_text': reasonText
    });
    var jsonResponse = jsonDecode(response.body);
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        textColor: Colors.green.shade900,
        backgroundColor: Colors.white,
        msg: jsonResponse['message']);
    OrderAcceptRejectResponse? orderAcceptRejectResponse;
    if (response.statusCode == 200) {
      return orderAcceptRejectResponse =
          OrderAcceptRejectResponse.fromMap(jsonResponse);
    }
    return orderAcceptRejectResponse;
  }
  // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

}

class OrderAcceptRejectResponse {
  late String status, message;

  OrderAcceptRejectResponse({required this.status, required this.message});

  OrderAcceptRejectResponse.fromMap(Map<String, dynamic> jsonResponse) {
    status = jsonResponse['status'];
    message = jsonResponse['message'];
  }
}
