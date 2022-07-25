import 'dart:convert';

class ProfileRequesst {
  late String name;
  late String email;
  late String filename;
  late String userid;
  ProfileRequesst({
    required this.name,
    required this.email,
    required this.filename,
    required this.userid,
  });

  ProfileRequesst copyWith({
    String? name,
    String? email,
    String? filename,
    String? userid,
  }) {
    return ProfileRequesst(
      name: name ?? this.name,
      email: email ?? this.email,
      filename: filename ?? this.filename,
      userid: userid ?? this.userid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'file_name': filename,
      'user_id': userid,
    };
  }

  factory ProfileRequesst.fromMap(Map<String, dynamic> map) {
    return ProfileRequesst(
      name: map['name'],
      email: map['email'],
      filename: map['file_name'],
      userid: map['user_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileRequesst.fromJson(String source) =>
      ProfileRequesst.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileRequesst(name: $name, email: $email, file_name: $filename, user_id: $userid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileRequesst &&
        other.name == name &&
        other.email == email &&
        other.filename == filename &&
        other.userid == userid;
  }

  @override
  int get hashCode {
    return name.hashCode ^ email.hashCode ^ filename.hashCode ^ userid.hashCode;
  }
}

// ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
class ProfileRespones {
  late bool status;
  late String errorCode;
  late String message;
  ProfileRespones({
    required this.status,
    required this.errorCode,
    required this.message,
  });

  ProfileRespones copyWith({
    bool? status,
    String? errorCode,
    String? message,
  }) {
    return ProfileRespones(
      status: status ?? this.status,
      errorCode: errorCode ?? this.errorCode,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'errorCode': errorCode,
      'message': message,
    };
  }

  factory ProfileRespones.fromMap(Map<String, dynamic> map) {
    return ProfileRespones(
      status: map['status'],
      errorCode: map['errorCode'],
      message: map['message'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileRespones.fromJson(String source) =>
      ProfileRespones.fromMap(json.decode(source));

  @override
  String toString() =>
      'ProfileRespones(status: $status, errorCode: $errorCode, message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileRespones &&
        other.status == status &&
        other.errorCode == errorCode &&
        other.message == message;
  }

  @override
  int get hashCode => status.hashCode ^ errorCode.hashCode ^ message.hashCode;
}

class ProfileDetails {
  final String name, phoneNumber, latitude, longitude, address, profileImage;
  String? userID;
  ProfileDetails(
      {required this.name,
      required this.profileImage,
      required this.latitude,
      required this.longitude,
      required this.phoneNumber,
      required this.address,
      this.userID});

  factory ProfileDetails.fromMap(
      {Map<dynamic, dynamic>? data, String? documentId}) {
    return ProfileDetails(
      userID: documentId,
      latitude: data?['latitude'] ?? "",
      longitude: data?['longitude'] ?? "",
      profileImage: data?['profileImage'] ?? "",
      name: data?['name'] ?? "",
      address: data?['address'],
      phoneNumber: data?['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'name': name,
      'address': address,
      'phoneNumber': phoneNumber,
    };
  }
}

class ProfileUpdateRequestModel {
  final String name, email, userId;

  ProfileUpdateRequestModel(this.name, this.email, this.userId);

  toMap() {
    return {"name": name, "email": email, "user_Id": userId};
  }
}

class ProfileUpdateResponseModel {
  bool? status;
  String? errorCode;
  String? message;

  ProfileUpdateResponseModel({this.status, this.errorCode, this.message});

  ProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['errorCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['errorCode'] = errorCode;
    data['message'] = message;
    return data;
  }
}

class ProfileResponseModel {
  String? status;
  String? message;
  String? userId;
  UserDetails? userDetails;
  String? profileBaseurl;

  ProfileResponseModel(
      {this.status,
      this.message,
      this.userId,
      this.userDetails,
      this.profileBaseurl});

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    userDetails = json['user_details'] != null
        ? UserDetails.fromJson(json['user_details'])
        : null;
    profileBaseurl = json['profile_baseurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['user_id'] = userId;
    if (userDetails != null) {
      data['user_details'] = userDetails!.toJson();
    }
    data['profile_baseurl'] = profileBaseurl;
    return data;
  }
}

class UserDetails {
  String? id;
  String? languageType;
  String? countryId;
  String? userName;
  String? mobile;
  String? email;
  String? password;
  String? decryptPassword;
  String? pwdOtp;
  String? dob;
  String? address;
  String? atharImage;
  String? pancardImage;
  String? drivingLicense;
  String? voterImage;
  String? deviceType;
  String? deviceToken;
  String? status;
  String? createdAt;
  String? updatedAt;

  UserDetails(
      {this.id,
      this.languageType,
      this.countryId,
      this.userName,
      this.mobile,
      this.email,
      this.password,
      this.decryptPassword,
      this.pwdOtp,
      this.dob,
      this.address,
      this.atharImage,
      this.pancardImage,
      this.drivingLicense,
      this.voterImage,
      this.deviceType,
      this.deviceToken,
      this.status,
      this.createdAt,
      this.updatedAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    languageType = json['language_type'];
    countryId = json['country_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    decryptPassword = json['decrypt password'];
    pwdOtp = json['pwd_otp'];
    dob = json['dob'];
    address = json['address'];
    atharImage = json['athar_image'];
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
    data['language_type'] = languageType;
    data['country_id'] = countryId;
    data['user_name'] = userName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['password'] = password;
    data['decrypt password'] = decryptPassword;
    data['pwd_otp'] = pwdOtp;
    data['dob'] = dob;
    data['address'] = address;
    data['athar_image'] = atharImage;
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
