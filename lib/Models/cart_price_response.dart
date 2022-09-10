class CartPriceResponseModel {
  String? status;
  String? message;
  String? vehicleBaseurl;
  String? gstPercentage;
  String? total;
  CartListDetails? cartListDetails;

  CartPriceResponseModel(
      {this.status,
      this.message,
      this.vehicleBaseurl,
      this.gstPercentage,
      this.total,
      this.cartListDetails});

  CartPriceResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vehicleBaseurl = json['vehicle_baseurl'];
    gstPercentage = json['gst_percentage'];
    total = json['total'];
    cartListDetails = json['cart_list_details'] != null
        ? CartListDetails.fromJson(json['cart_list_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['vehicle_baseurl'] = vehicleBaseurl;
    data['gst_percentage'] = gstPercentage;
    data['total'] = total;
    if (cartListDetails != null) {
      data['cart_list_details'] = cartListDetails!.toJson();
    }
    return data;
  }
}

class CartListDetails {
  String? userId;
  CustomerDetails? customerDetails;
  VehicleDetails? vehicleDetails;
  String? waitingCharge;
  String? fromLat;
  String? fromLong;
  String? fromAddress;
  String? toLat;
  String? toLong;
  String? toAddress;

  CartListDetails(
      {this.userId,
      this.customerDetails,
      this.vehicleDetails,
      this.waitingCharge,
      this.fromLat,
      this.fromLong,
      this.fromAddress,
      this.toLat,
      this.toLong,
      this.toAddress});

  CartListDetails.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    customerDetails = json['Customer_details'] != null
        ? new CustomerDetails.fromJson(json['Customer_details'])
        : null;
    vehicleDetails = json['vehicle_details'] != null
        ? VehicleDetails.fromJson(json['vehicle_details'])
        : null;
    waitingCharge = json['waiting_charge'];
    fromLat = json['from_lat'];
    fromLong = json['from_long'];
    fromAddress = json['from_address'];
    toLat = json['to_lat'];
    toLong = json['to_long'];
    toAddress = json['to_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_id'] = userId;
    if (customerDetails != null) {
      data['Customer_details'] = customerDetails!.toJson();
    }
    if (vehicleDetails != null) {
      data['vehicle_details'] = vehicleDetails!.toJson();
    }
    data['waiting_charge'] = waitingCharge;
    data['from_lat'] = fromLat;
    data['from_long'] = fromLong;
    data['from_address'] = fromAddress;
    data['to_lat'] = toLat;
    data['to_long'] = toLong;
    data['to_address'] = toAddress;
    return data;
  }
}

class CustomerDetails {
  String? id;
  String? firebaseId;
  String? languageType;
  String? countryId;
  String? userName;
  String? mobile;
  String? orderMobile;
  String? email;
  String? password;
  String? decryptPassword;
  String? pwdOtp;
  String? dob;
  String? address;
  String? atharImage;
  String? profileImage;
  String? pancardImage;
  String? drivingLicense;
  String? voterImage;
  String? deviceType;
  String? deviceToken;
  String? status;
  String? createdAt;
  String? updatedAt;

  CustomerDetails(
      {this.id,
      this.firebaseId,
      this.languageType,
      this.countryId,
      this.userName,
      this.mobile,
      this.orderMobile,
      this.email,
      this.password,
      this.decryptPassword,
      this.pwdOtp,
      this.dob,
      this.address,
      this.atharImage,
      this.profileImage,
      this.pancardImage,
      this.drivingLicense,
      this.voterImage,
      this.deviceType,
      this.deviceToken,
      this.status,
      this.createdAt,
      this.updatedAt});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    languageType = json['language_type'];
    countryId = json['country_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    orderMobile = json['order_mobile'];
    email = json['email'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    pwdOtp = json['pwd_otp'];
    dob = json['dob'];
    address = json['address'];
    atharImage = json['athar_image'];
    profileImage = json['profile_image'];
    pancardImage = json['pancard_image'];
    drivingLicense = json['driving_license'];
    voterImage = json['voter_image'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['firebase_id'] = firebaseId;
    data['language_type'] = languageType;
    data['country_id'] = countryId;
    data['user_name'] = userName;
    data['mobile'] = mobile;
    data['order_mobile'] = orderMobile;
    data['email'] = email;
    data['password'] = password;
    data['decrypt_password'] = decryptPassword;
    data['pwd_otp'] = pwdOtp;
    data['dob'] = dob;
    data['address'] = address;
    data['athar_image'] = atharImage;
    data['profile_image'] = profileImage;
    data['pancard_image'] = pancardImage;
    data['driving_license'] = drivingLicense;
    data['voter_image'] = voterImage;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class VehicleDetails {
  String? id;
  String? labour;
  String? wheeler;
  String? pricePerKm;
  String? image;
  String? status;
  String? createdAt;

  VehicleDetails(
      {this.id,
      this.labour,
      this.wheeler,
      this.pricePerKm,
      this.image,
      this.status,
      this.createdAt});

  VehicleDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    labour = json['labour'];
    wheeler = json['wheeler'];
    pricePerKm = json['price_per_km'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['labour'] = labour;
    data['wheeler'] = wheeler;
    data['price_per_km'] = pricePerKm;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
