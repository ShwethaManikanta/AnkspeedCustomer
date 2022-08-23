class BookVehicleResponseModel {
  String? status;
  String? message;
  TripDetails? tripDetails;

  BookVehicleResponseModel({this.status, this.message, this.tripDetails});

  BookVehicleResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    tripDetails = json['trip_details'] != null
        ? TripDetails.fromJson(json['trip_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (tripDetails != null) {
      data['trip_details'] = tripDetails!.toJson();
    }
    return data;
  }
}

class TripDetails {
  String? id;
  String? userId;
  String? driverId;
  String? customerName;
  String? customerMobile;
  String? vehicleTypeId;
  String? labour;
  String? tripOtp;
  String? fromLat;
  String? fromLong;
  String? fromAddress;
  String? toLat;
  String? toLong;
  String? toAddress;
  String? totalDistance;
  String? totalDuration;
  String? total;
  String? transactionId;
  String? payedAmt;
  String? rideDate;
  String? rideTime;
  String? nearByPlace;
  String? pickupPoint;
  String? ongoingStatus;
  String? tripStatus;
  String? status;
  String? createdAt;
  String? updatedAt;

  TripDetails(
      {this.id,
      this.userId,
      this.driverId,
      this.customerName,
      this.customerMobile,
      this.vehicleTypeId,
      this.labour,
      this.tripOtp,
      this.fromLat,
      this.fromLong,
      this.fromAddress,
      this.toLat,
      this.toLong,
      this.toAddress,
      this.totalDistance,
      this.totalDuration,
      this.total,
      this.transactionId,
      this.payedAmt,
      this.rideDate,
      this.rideTime,
      this.nearByPlace,
      this.pickupPoint,
      this.ongoingStatus,
      this.tripStatus,
      this.status,
      this.createdAt,
      this.updatedAt});

  TripDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    customerName = json['customer_name'];
    customerMobile = json['customer_mobile'];
    vehicleTypeId = json['vehicle_type_id'];
    labour = json['labour'];
    tripOtp = json['trip_otp'];
    fromLat = json['from_lat'];
    fromLong = json['from_long'];
    fromAddress = json['from_address'];
    toLat = json['to_lat'];
    toLong = json['to_long'];
    toAddress = json['to_address'];
    totalDistance = json['total_distance'];
    totalDuration = json['total_duration'];
    total = json['total'];
    transactionId = json['transaction_id'];
    payedAmt = json['payed_amt'];
    rideDate = json['ride_date'];
    rideTime = json['ride_time'];
    nearByPlace = json['near_by_place'];
    pickupPoint = json['pickup_point'];
    ongoingStatus = json['ongoing_status'];
    tripStatus = json['trip_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['Updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_id'] = userId;
    data['driver_id'] = driverId;
    data['customer_name'] = customerName;
    data['customer_mobile'] = customerMobile;
    data['vehicle_type_id'] = vehicleTypeId;
    data['labour'] = labour;
    data['trip_otp'] = tripOtp;
    data['from_lat'] = fromLat;
    data['from_long'] = fromLong;
    data['from_address'] = fromAddress;
    data['to_lat'] = toLat;
    data['to_long'] = toLong;
    data['to_address'] = toAddress;
    data['total_distance'] = totalDistance;
    data['total_duration'] = totalDuration;
    data['total'] = total;
    data['transaction_id'] = transactionId;
    data['payed_amt'] = payedAmt;
    data['ride_date'] = rideDate;
    data['ride_time'] = rideTime;
    data['near_by_place'] = nearByPlace;
    data['pickup_point'] = pickupPoint;
    data['ongoing_status'] = ongoingStatus;
    data['trip_status'] = tripStatus;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['Updated_at'] = updatedAt;
    return data;
  }
}

class BookVehicleRequestModel {
  final String userId,
      customerName,
      customerMobile,
      vehicleTypeId,
      categoryId,
      categoryQuantity,
      labourQuantity,
      labourPrice,
      stateStatus,
      statePrice,
      gst,
      duration,
      distance,
      total,
      fromLat,
      fromLong,
      fromAddress,
      toLat,
      toLong,
      toAddress,
      toName,
      toMobile,
      transactionId,
      paidAmt,
      vehicleCharge,
      timeState,
      rideTime,
      discountAmt,
      couponCode;

  BookVehicleRequestModel({
    required this.userId,
    required this.vehicleTypeId,
    required this.customerName,
    required this.customerMobile,
    required this.categoryId,
    required this.categoryQuantity,
    required this.labourQuantity,
    required this.labourPrice,
    required this.stateStatus,
    required this.statePrice,
    required this.gst,
    required this.duration,
    required this.distance,
    required this.total,
    required this.fromLat,
    required this.fromLong,
    required this.fromAddress,
    required this.toLat,
    required this.toLong,
    required this.toAddress,
    required this.transactionId,
    required this.paidAmt,
    required this.rideTime,
    required this.timeState,
    required this.toName,
    required this.toMobile,
    required this.vehicleCharge,
    required this.discountAmt,
    required this.couponCode,
  });

  toMap() {
    return {
      'user_id': userId,
      'customer_name': customerName,
      'customer_mobile': customerMobile,
      'vehicle_type_id': vehicleTypeId,
      'category_id': categoryId,
      'category_qty': categoryQuantity,
      'labour_qty': labourQuantity,
      'labour_price': labourPrice,
      'state_status': stateStatus,
      'state_price': statePrice,
      'gst': gst,
      'duration': duration,
      'distance': distance,
      'total': total,
      'from_lat': fromLat,
      'from_long': fromLong,
      'from_address': fromAddress,
      'to_lat': toLat,
      'to_long': toLong,
      'to_address': toAddress,
      'transaction_id': transactionId,
      'paid_amt': paidAmt,
      'vehicle_charge': vehicleCharge,
      'time_state': timeState,
      'ride_time': rideTime,
      'to_name': toName,
      'to_mobile': toMobile,
      'discount_amt': discountAmt,
      'coupon_code': couponCode,
    };
  }
}
