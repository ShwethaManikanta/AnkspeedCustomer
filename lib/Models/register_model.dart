class RegisterRequestModel {
  final String name, email, mobile, password, address;

  RegisterRequestModel(
      {required this.name,
      required this.email,
      required this.mobile,
      required this.password,
      required this.address});

  toMap() {
    return {
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
      'address': address
    };
  }
}

class RegistrationResponseModel {
  String? status;
  String? message;
  String? errorCode;
  Data? data;

  RegistrationResponseModel(
      {this.status, this.message, this.errorCode, this.data});

  RegistrationResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    errorCode = json['errorCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['errorCode'] = errorCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? created;
  String? name;
  String? email;
  int? mobile;
  String? address;
  String? password;
  int? isActive;

  Data(
      {this.created,
      this.name,
      this.email,
      this.mobile,
      this.address,
      this.password,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    password = json['password'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['created'] = created;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['address'] = address;
    data['password'] = password;
    data['is_active'] = isActive;
    return data;
  }
}
