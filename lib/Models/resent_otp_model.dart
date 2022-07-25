import 'dart:convert';

class ResentOtpRequest {
  late int mobile;
  ResentOtpRequest({
    required this.mobile,
  });

  ResentOtpRequest copyWith({
    int? mobile,
  }) {
    return ResentOtpRequest(
      mobile: mobile ?? this.mobile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mobile': mobile,
    };
  }

  factory ResentOtpRequest.fromMap(Map<String, dynamic> map) {
    return ResentOtpRequest(
      mobile: map['mobile'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResentOtpRequest.fromJson(String source) =>
      ResentOtpRequest.fromMap(json.decode(source));

  @override
  String toString() => 'ResentOtpRequest(mobile: $mobile)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResentOtpRequest && other.mobile == mobile;
  }

  @override
  int get hashCode => mobile.hashCode;
}

// ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
class ResentOtpRespones {
  late String status;
  late String message;
  late String errorCode;
  late Data data;
  ResentOtpRespones({
    required this.status,
    required this.message,
    required this.errorCode,
    required this.data,
  });

  ResentOtpRespones copyWith({
    String? status,
    String? message,
    String? errorCode,
    Data? data,
  }) {
    return ResentOtpRespones(
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

  factory ResentOtpRespones.fromMap(Map<String, dynamic> map) {
    return ResentOtpRespones(
      status: map['status'],
      message: map['message'],
      errorCode: map['errorCode'],
      data: Data.fromMap(map['data']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResentOtpRespones.fromJson(String source) =>
      ResentOtpRespones.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ResentOtpRespones(status: $status, message: $message, errorCode: $errorCode, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ResentOtpRespones &&
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
