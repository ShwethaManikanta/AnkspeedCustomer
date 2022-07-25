class NearByDriverListModel {
  String? status;
  String? message;
  String? vehicleBaseurl;
  String? driverBaseurl;
  List<NearByVehicleList>? vehicleList;

  NearByDriverListModel(
      {this.status,
      this.message,
      this.vehicleBaseurl,
      this.driverBaseurl,
      this.vehicleList});

  NearByDriverListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vehicleBaseurl = json['vehicle_baseurl'];
    driverBaseurl = json['driver_baseurl'];
    if (json['vehicle_list'] != null) {
      vehicleList = <NearByVehicleList>[];
      json['vehicle_list'].forEach((v) {
        vehicleList!.add(new NearByVehicleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['vehicle_baseurl'] = this.vehicleBaseurl;
    data['driver_baseurl'] = this.driverBaseurl;
    if (this.vehicleList != null) {
      data['vehicle_list'] = this.vehicleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NearByVehicleList {
  String? id;
  String? type;
  String? driverType;
  String? vehicleWheelType;
  String? driverName;
  String? phoneNo;
  String? email;
  String? dob;
  String? age;
  String? vehicleNumber;
  String? profileImage;
  String? licensePicture;
  String? rcImage;
  String? insuranceImage;
  String? emissionImage;
  String? roadTaxImage;
  String? permitImage;
  String? fcImage;
  String? address;
  String? password;
  String? decryptPassword;
  String? notification;
  String? onlineStatus;
  int? status;
  String? latitude;
  String? longitude;
  String? deviceToken;
  String? deviceVersion;
  String? deviceType;
  String? deviceModel;
  String? createdAt;
  String? updatedAt;
  String? distanceInKm;

  NearByVehicleList(
      {this.id,
      this.type,
      this.driverType,
      this.vehicleWheelType,
      this.driverName,
      this.phoneNo,
      this.email,
      this.dob,
      this.age,
      this.vehicleNumber,
      this.profileImage,
      this.licensePicture,
      this.rcImage,
      this.insuranceImage,
      this.emissionImage,
      this.roadTaxImage,
      this.permitImage,
      this.fcImage,
      this.address,
      this.password,
      this.decryptPassword,
      this.notification,
      this.onlineStatus,
      this.status,
      this.latitude,
      this.longitude,
      this.deviceToken,
      this.deviceVersion,
      this.deviceType,
      this.deviceModel,
      this.createdAt,
      this.updatedAt,
      this.distanceInKm});

  NearByVehicleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    driverType = json['driver_type'];
    vehicleWheelType = json['vehicle_wheel_type'];
    driverName = json['driver_name'];
    phoneNo = json['phone_no'];
    email = json['email'];
    dob = json['dob'];
    age = json['age'];
    vehicleNumber = json['vehicle_number'];
    profileImage = json['profile_image'];
    licensePicture = json['license_picture'];
    rcImage = json['rc_image'];
    insuranceImage = json['insurance_image'];
    emissionImage = json['emission_image'];
    roadTaxImage = json['road_tax_image'];
    permitImage = json['permit_image'];
    fcImage = json['fc_image'];
    address = json['address'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    notification = json['notification'];
    onlineStatus = json['online_status'];
    status = json['status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    deviceToken = json['device_token'];
    deviceVersion = json['device_version'];
    deviceType = json['device_type'];
    deviceModel = json['device_model'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    distanceInKm = json['distance_in_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['driver_type'] = this.driverType;
    data['vehicle_wheel_type'] = this.vehicleWheelType;
    data['driver_name'] = this.driverName;
    data['phone_no'] = this.phoneNo;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['vehicle_number'] = this.vehicleNumber;
    data['profile_image'] = this.profileImage;
    data['license_picture'] = this.licensePicture;
    data['rc_image'] = this.rcImage;
    data['insurance_image'] = this.insuranceImage;
    data['emission_image'] = this.emissionImage;
    data['road_tax_image'] = this.roadTaxImage;
    data['permit_image'] = this.permitImage;
    data['fc_image'] = this.fcImage;
    data['address'] = this.address;
    data['password'] = this.password;
    data['decrypt_password'] = this.decryptPassword;
    data['notification'] = this.notification;
    data['online_status'] = this.onlineStatus;
    data['status'] = this.status;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['device_token'] = this.deviceToken;
    data['device_version'] = this.deviceVersion;
    data['device_type'] = this.deviceType;
    data['device_model'] = this.deviceModel;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['distance_in_km'] = this.distanceInKm;
    return data;
  }
}
