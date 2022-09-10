import 'dart:convert';

class ProfileViewRequest {
  late int userId;
  ProfileViewRequest({
    required this.userId,
  });

  ProfileViewRequest copyWith({
    int? userId,
  }) {
    return ProfileViewRequest(
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
    };
  }

  factory ProfileViewRequest.fromMap(Map<String, dynamic> map) {
    return ProfileViewRequest(
      userId: map['user_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileViewRequest.fromJson(String source) =>
      ProfileViewRequest.fromMap(json.decode(source));

  @override
  String toString() => 'ProfileViewRequest(user_id: $userId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileViewRequest && other.userId == userId;
  }

  @override
  int get hashCode => userId.hashCode;
}

// ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
class ProfileViewRespones {
  late String status;
  late String message;
  late String errorCode;
  late Data data;
  ProfileViewRespones({
    required this.status,
    required this.message,
    required this.errorCode,
    required this.data,
  });

  ProfileViewRespones copyWith({
    String? status,
    String? message,
    String? errorCode,
    Data? data,
  }) {
    return ProfileViewRespones(
      status: status ?? this.status,
      message: message ?? this.message,
      errorCode: errorCode ?? this.errorCode,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'errorCode': errorCode,
      'data': data.toMap(),
    };
  }

  factory ProfileViewRespones.fromMap(Map<String, dynamic> map) {
    return ProfileViewRespones(
      status: map['status'],
      message: map['message'],
      errorCode: map['errorCode'],
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileViewRespones.fromJson(String source) =>
      ProfileViewRespones.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProfileViewRespones(status: $status, message: $message, errorCode: $errorCode, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProfileViewRespones &&
        other.status == status &&
        other.message == message &&
        other.errorCode == errorCode &&
        other.data == data;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        errorCode.hashCode ^
        data.hashCode;
  }
}

class Data {
  late String userId;
  late String name;
  late String email;
  late String mobile;
  late String fileName;
  Data({
    required this.userId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.fileName,
  });

  Data copyWith({
    String? userId,
    String? name,
    String? email,
    String? mobile,
    String? fileName,
  }) {
    return Data(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      fileName: fileName ?? this.fileName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'mobile': mobile,
      'file_name': fileName,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      userId: map['user_id'],
      name: map['name'],
      email: map['email'],
      mobile: map['mobile'],
      fileName: map['file_name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Data(user_id: $userId, name: $name, email: $email, mobile: $mobile, file_name: $fileName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data &&
        other.userId == userId &&
        other.name == name &&
        other.email == email &&
        other.mobile == mobile &&
        other.fileName == fileName;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        name.hashCode ^
        email.hashCode ^
        mobile.hashCode ^
        fileName.hashCode;
  }
}

class ProfileViewResponseModel {
  String? status;
  String? message;
  String? userId;
  UserDetails? userDetails;
  String? profileBaseurl;

  ProfileViewResponseModel(
      {this.status,
      this.message,
      this.userId,
      this.userDetails,
      this.profileBaseurl});

  ProfileViewResponseModel.fromJson(Map<String, dynamic> json) {
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

  UserDetails(
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

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    languageType = json['language_type'];
    countryId = json['country_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    orderMobile = json['order_mobile'];
    email = json['email'];
    password = json['password'];
    decryptPassword = json['decrypt password'];
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
    data['decrypt password'] = decryptPassword;
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
