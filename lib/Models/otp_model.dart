import 'dart:convert';

class OtpRequest {
  late int mobile;
  OtpRequest({
    required this.mobile,
  });

  OtpRequest copyWith({
    int? mobile,
  }) {
    return OtpRequest(
      mobile: mobile ?? this.mobile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mobile': mobile,
    };
  }

  factory OtpRequest.fromMap(Map<String, dynamic> map) {
    return OtpRequest(
      mobile: map['mobile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpRequest.fromJson(String source) =>
      OtpRequest.fromMap(json.decode(source));

  @override
  String toString() => 'OtpRequest(mobile: $mobile)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OtpRequest && other.mobile == mobile;
  }

  @override
  int get hashCode => mobile.hashCode;
}

//,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
class OtpRespones {
  late String status;
  late String message;
  late String errorCode;
  late Data data;
  OtpRespones({
    required this.status,
    required this.message,
    required this.errorCode,
    required this.data,
  });

  OtpRespones copyWith({
    String? status,
    String? message,
    String? errorCode,
    Data? data,
  }) {
    return OtpRespones(
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

  factory OtpRespones.fromMap(Map<String, dynamic> map) {
    return OtpRespones(
      status: map['status'],
      message: map['message'],
      errorCode: map['errorCode'],
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpRespones.fromJson(String source) =>
      OtpRespones.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OtpRespones(status: $status, message: $message, errorCode: $errorCode, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OtpRespones &&
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
  late String otp;
  Data({
    required this.otp,
  });

  Data copyWith({
    String? otp,
  }) {
    return Data(
      otp: otp ?? this.otp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'otp': otp,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      otp: map['otp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() => 'Data(otp: $otp)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Data && other.otp == otp;
  }

  @override
  int get hashCode => otp.hashCode;
}
