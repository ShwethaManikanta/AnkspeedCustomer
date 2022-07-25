class VehicleListResponseModel {
  String? status;
  String? message;
  String? errorCode;
  List<Data>? data;

  VehicleListResponseModel(
      {this.status, this.message, this.errorCode, this.data});

  VehicleListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['errorCode'] = errorCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? driverId;
  String? vehicleCategoryId;
  String? vehicleName;
  String? driverName;
  String? vehicleNumber;
  String? img;
  String? driverImage;

  Data(
      {this.driverId,
      this.vehicleCategoryId,
      this.vehicleName,
      this.driverName,
      this.vehicleNumber,
      this.img,
      this.driverImage});

  Data.fromJson(Map<String, dynamic> json) {
    driverId = json['driver_id'];
    vehicleCategoryId = json['vehicle_category_id'];
    vehicleName = json['vehicle_name'];
    driverName = json['driver_name'];
    vehicleNumber = json['vehicle_number'];
    img = json['img'];
    driverImage = json['driver_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['driver_id'] = driverId;
    data['vehicle_category_id'] = vehicleCategoryId;
    data['vehicle_name'] = vehicleName;
    data['driver_name'] = driverName;
    data['vehicle_number'] = vehicleNumber;
    data['img'] = img;
    data['driver_image'] = driverImage;
    return data;
  }
}

class SubVehicleListResponseModel {
  String? status;
  String? message;
  String? vehicleBaseurl;
  String? driverBaseurl;
  List<SubVehicleList>? vehicleList;

  SubVehicleListResponseModel(
      {this.status,
      this.message,
      this.vehicleBaseurl,
      this.driverBaseurl,
      this.vehicleList});

  SubVehicleListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vehicleBaseurl = json['vehicle_baseurl'];
    driverBaseurl = json['driver_baseurl'];
    if (json['vehicle_list'] != null) {
      vehicleList = <SubVehicleList>[];
      json['vehicle_list'].forEach((v) {
        vehicleList!.add(SubVehicleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['vehicle_baseurl'] = vehicleBaseurl;
    data['driver_baseurl'] = driverBaseurl;
    if (vehicleList != null) {
      data['vehicle_list'] = vehicleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubVehicleList {
  String? id;
  String? vehicleWheelType;
  String? driverName;
  String? phoneNo;
  String? email;
  String? dob;
  String? age;
  String? verify;
  String? vehicleNumber;
  String? insuranceNumber;
  String? vehicleType;
  String? vehicleModel;
  String? vehicleColor;
  String? profileImage;
  String? licensePicture;
  String? vehiclePicture;
  String? vehicleInsurance;
  String? address;
  String? password;
  String? decryptPassword;
  String? notification;
  String? tripStatus;
  String? status;
  String? latitude;
  String? longitude;
  String? deviceToken;
  String? deviceVersion;
  String? deviceType;
  String? deviceModel;
  String? createdAt;
  String? updatedAt;
  String? wheeler;
  String? pricePerKm;
  String? image;

  SubVehicleList(
      {this.id,
      this.vehicleWheelType,
      this.driverName,
      this.phoneNo,
      this.email,
      this.dob,
      this.age,
      this.verify,
      this.vehicleNumber,
      this.insuranceNumber,
      this.vehicleType,
      this.vehicleModel,
      this.vehicleColor,
      this.profileImage,
      this.licensePicture,
      this.vehiclePicture,
      this.vehicleInsurance,
      this.address,
      this.password,
      this.decryptPassword,
      this.notification,
      this.tripStatus,
      this.status,
      this.latitude,
      this.longitude,
      this.deviceToken,
      this.deviceVersion,
      this.deviceType,
      this.deviceModel,
      this.createdAt,
      this.updatedAt,
      this.wheeler,
      this.pricePerKm,
      this.image});

  SubVehicleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleWheelType = json['vehicle_wheel_type'];
    driverName = json['driver_name'];
    phoneNo = json['phone_no'];
    email = json['email'];
    dob = json['dob'];
    age = json['age'];
    verify = json['verify'];
    vehicleNumber = json['vehicle_number'];
    insuranceNumber = json['insurance_number'];
    vehicleType = json['vehicle_type'];
    vehicleModel = json['vehicle_model'];
    vehicleColor = json['vehicle_color'];
    profileImage = json['profile_image'];
    licensePicture = json['license_picture'];
    vehiclePicture = json['vehicle_picture'];
    vehicleInsurance = json['vehicle_insurance'];
    address = json['address'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    notification = json['notification'];
    tripStatus = json['trip_status'];
    status = json['status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deviceToken = json['device_token'];
    deviceVersion = json['device_version'];
    deviceType = json['device_type'];
    deviceModel = json['device_model'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    wheeler = json['wheeler'];
    pricePerKm = json['price_per_km'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['vehicle_wheel_type'] = vehicleWheelType;
    data['driver_name'] = driverName;
    data['phone_no'] = phoneNo;
    data['email'] = email;
    data['dob'] = dob;
    data['age'] = age;
    data['verify'] = verify;
    data['vehicle_number'] = vehicleNumber;
    data['insurance_number'] = insuranceNumber;
    data['vehicle_type'] = vehicleType;
    data['vehicle_model'] = vehicleModel;
    data['vehicle_color'] = vehicleColor;
    data['profile_image'] = profileImage;
    data['license_picture'] = licensePicture;
    data['vehicle_picture'] = vehiclePicture;
    data['vehicle_insurance'] = vehicleInsurance;
    data['address'] = address;
    data['password'] = password;
    data['decrypt_password'] = decryptPassword;
    data['notification'] = notification;
    data['trip_status'] = tripStatus;
    data['status'] = status;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['device_token'] = deviceToken;
    data['device_version'] = deviceVersion;
    data['device_type'] = deviceType;
    data['device_model'] = deviceModel;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['wheeler'] = wheeler;
    data['price_per_km'] = pricePerKm;
    data['image'] = image;
    return data;
  }
}
