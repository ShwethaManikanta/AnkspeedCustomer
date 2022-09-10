import 'dart:convert';

class UserApi {
  String? status;
  String? message;
  String? user_id;
  UserModel? user_details;
  List<UserModel>? get_all_address;

  UserApi(
      {this.user_details,
      this.status,
      this.message,
      this.user_id,
      this.get_all_address});

  UserApi copyWith(
      {String? status,
      String? message,
      String? user_id,
      UserModel? user_details}) {
    return UserApi(
      status: status ?? this.status,
      message: message ?? this.message,
      user_id: user_id ?? this.user_id,
      get_all_address: get_all_address ?? this.get_all_address,
      user_details: user_details ?? this.user_details,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'user_id': user_id,
      'get_all_address': get_all_address,
      'user_details': user_details,
    };
  }

  factory UserApi.fromMap(Map<String, dynamic> map) {
    return UserApi(
        status: map['status'],
        message: map['message'],
        user_id: map['user_id'],
        get_all_address: List.generate(
            map['get_all_address'].length,
            (index) => UserModel(
                  address_type_id: map['get_all_address'][index]
                      ['address_type_id'],
                  address: map['get_all_address'][index]['address'],
                  id: map['get_all_address'][index]['id'],
                  customer_name: map['get_all_address'][index]['customer_name'],
                  mobile: map['get_all_address'][index]['mobile'],
                  floor: map['get_all_address'][index]['floor'],
                  reach: map['get_all_address'][index]['reach'],
                  password: map['get_all_address'][index]['password'],
                  pwd_otp: map['get_all_address'][index]['pwd_otp'],
                  land_mark: map['get_all_address'][index]['land_mark'],
                  addtionalNumber: map['get_all_address'][index]
                      ['addtionalNumber'],
                  email: map['get_all_address'][index]['email'],
                  status: map['get_all_address'][index]['status'],
                  created_at: map['get_all_address'][index]['created_at'],
                  user_id: map['get_all_address'][index]['user_id'],
                  lat: map['get_all_address'][index]['lat'],
                  long: map['get_all_address'][index]['long'],
                )),
        user_details: UserModel.fromMap(
          map['user_details'],
        ));
  }

  String toJson() => json.encode(toMap());

  factory UserApi.fromJson(String source) =>
      UserApi.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(status: $status,get_all_address :$get_all_address, message: $message, user_id: $user_id, user_details: $user_details'
        ')';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserApi &&
        other.status == status &&
        other.message == message &&
        other.get_all_address == get_all_address &&
        other.user_id == user_id &&
        other.user_details == user_details;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        get_all_address.hashCode ^
        user_id.hashCode ^
        user_details.hashCode;
  }
}

class UserModel {
  String? id;
  String? customer_name;
  String? mobile;
  String? password;
  String? pwd_otp;
  String? land_mark;
  String? floor;
  String? reach;

  String? addtionalNumber;
  String? email;
  String? address;
  String? status;
  String? created_at;
  String? address_type_id;
  String? user_id;
  String? lat;
  String? long;

  UserModel(
      {this.id,
      this.customer_name,
      this.mobile,
      this.password,
      this.pwd_otp,
      this.land_mark,
      this.addtionalNumber,
      this.email,
      this.address,
      this.status,
      this.floor,
      this.reach,
      this.created_at,
      this.address_type_id,
      this.lat,
      this.long,
      this.user_id});

  UserModel copyWith({
    String? id,
    String? customer_name,
    String? mobile,
    String? password,
    String? pwd_otp,
    String? floor,
    String? reach,
    String? addtionalNumber,
    String? email,
    String? land_mark,
    String? address,
    String? status,
    String? created_at,
    String? address_type_id,
    String? user_id,
    String? lat,
    String? long,
  }) {
    return UserModel(
      id: id ?? this.id,
      floor: floor ?? this.floor,
      reach: reach ?? this.reach,
      customer_name: customer_name ?? this.customer_name,
      mobile: mobile ?? this.mobile,
      password: password ?? this.password,
      pwd_otp: pwd_otp ?? this.pwd_otp,
      land_mark: land_mark ?? this.land_mark,
      addtionalNumber: addtionalNumber ?? this.addtionalNumber,
      email: email ?? this.email,
      address_type_id: address_type_id ?? this.address_type_id,
      user_id: user_id ?? this.user_id,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      address: address ?? this.address,
      status: status ?? this.status,
      created_at: created_at ?? this.created_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'floor': floor,
      'reach': reach,
      'customer_name': customer_name,
      'mobile': mobile,
      'address_type_id': address_type_id,
      'user_id': user_id,
      'lat': lat,
      'land_mark': land_mark,
      'long': long,
      'password': password,
      'pwd_otp': pwd_otp,
      'addtional_number': addtionalNumber,
      'email': email,
      'address': address,
      'status': status,
      'created_at': created_at,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      floor: map['floor'],
      reach: map['reach'],
      land_mark: map['land_mark'],
      customer_name: map['customer_name'],
      mobile: map['mobile'],
      password: map['password'],
      pwd_otp: map['pwd_otp'],
      address_type_id: map['address_type_id'],
      user_id: map['user_id'],
      lat: map['lat'],
      long: map['long'],
      addtionalNumber: map['addtional_number'],
      email: map['email'],
      address: map['address'],
      status: map['status'],
      created_at: map['created_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id,floor:$floor,reach :$reach, customer_name: $customer_name,land_mark :$land_mark,address_type_id :$address_type_id,user_id :$user_id,lat :$lat,long :$long, mobile: $mobile, password: $password, pwd_otp: $pwd_otp, addtional_number: $addtionalNumber, email: $email, address: $address, status: $status, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.floor == floor &&
        other.reach == reach &&
        other.customer_name == customer_name &&
        other.mobile == mobile &&
        other.password == password &&
        other.land_mark == land_mark &&
        other.pwd_otp == pwd_otp &&
        other.addtionalNumber == addtionalNumber &&
        other.email == email &&
        other.address == address &&
        other.status == status &&
        other.address_type_id == address_type_id &&
        other.user_id == user_id &&
        other.lat == lat &&
        other.long == long &&
        other.created_at == created_at;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customer_name.hashCode ^
        floor.hashCode ^
        reach.hashCode ^
        mobile.hashCode ^
        password.hashCode ^
        pwd_otp.hashCode ^
        addtionalNumber.hashCode ^
        email.hashCode ^
        land_mark.hashCode ^
        address.hashCode ^
        status.hashCode ^
        address_type_id.hashCode ^
        user_id.hashCode ^
        lat.hashCode ^
        long.hashCode ^
        created_at.hashCode;
  }
}

class ProfileViewResponseModel {
  String? status;
  String? message;
  String? userId;
  AdminDetails? adminDetails;
  UserDetails? userDetails;
  String? bannerBaseurl;
  String? profileBaseurl;

  ProfileViewResponseModel(
      {this.status,
      this.message,
      this.userId,
      this.adminDetails,
      this.userDetails,
      this.bannerBaseurl,
      this.profileBaseurl});

  ProfileViewResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    adminDetails = json['admin_details'] != null
        ? new AdminDetails.fromJson(json['admin_details'])
        : null;
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
    bannerBaseurl = json['banner_baseurl'];
    profileBaseurl = json['profile_baseurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    if (this.adminDetails != null) {
      data['admin_details'] = this.adminDetails!.toJson();
    }
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    data['banner_baseurl'] = this.bannerBaseurl;
    data['profile_baseurl'] = this.profileBaseurl;
    return data;
  }
}

class AdminDetails {
  String? id;
  String? terms;
  String? description;
  String? cgst;
  String? sgst;
  String? withdrawalLimit;
  String? adminCm;
  String? mobileNo;
  String? mail;
  String? status;
  String? createdAt;

  AdminDetails(
      {this.id,
      this.terms,
      this.description,
      this.cgst,
      this.sgst,
      this.withdrawalLimit,
      this.adminCm,
      this.mobileNo,
      this.mail,
      this.status,
      this.createdAt});

  AdminDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    terms = json['terms'];
    description = json['description'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    withdrawalLimit = json['withdrawal_limit'];
    adminCm = json['admin_cm'];
    mobileNo = json['mobile_no'];
    mail = json['mail'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['terms'] = this.terms;
    data['description'] = this.description;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['withdrawal_limit'] = this.withdrawalLimit;
    data['admin_cm'] = this.adminCm;
    data['mobile_no'] = this.mobileNo;
    data['mail'] = this.mail;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class UserDetails {
  String? id;
  String? firebaseId;
  String? userName;
  String? mobile;
  String? email;
  String? password;
  String? decryptPassword;
  String? deviceType;
  String? deviceToken;
  String? status;
  String? createdAt;
  String? updatedAt;

  UserDetails(
      {this.id,
      this.firebaseId,
      this.userName,
      this.mobile,
      this.email,
      this.password,
      this.decryptPassword,
      this.deviceType,
      this.deviceToken,
      this.status,
      this.createdAt,
      this.updatedAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firebaseId = json['firebase_id'];
    userName = json['user_name'];
    mobile = json['mobile'];
    email = json['email'];
    password = json['password'];
    decryptPassword = json['decrypt_password'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firebase_id'] = this.firebaseId;
    data['user_name'] = this.userName;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['password'] = this.password;
    data['decrypt_password'] = this.decryptPassword;
    data['device_type'] = this.deviceType;
    data['device_token'] = this.deviceToken;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
