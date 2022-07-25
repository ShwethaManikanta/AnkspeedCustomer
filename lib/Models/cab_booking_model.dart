class CabBookingModel {
  String? status;
  String? message;
  TripDetails? tripDetails;

  CabBookingModel({this.status, this.message, this.tripDetails});

  CabBookingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    tripDetails = json['trip_details'] != null
        ? new TripDetails.fromJson(json['trip_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.tripDetails != null) {
      data['trip_details'] = this.tripDetails!.toJson();
    }
    return data;
  }
}

class TripDetails {
  String? id;
  String? driverType;
  String? userId;
  String? driverId;
  String? startLoadingTime;
  String? endLoadingTime;
  String? startUnloadingTime;
  String? endUnloadingTime;
  String? startTripTime;
  String? endTripTime;
  String? customerName;
  String? customerMobile;
  String? customerVerifyStatus;
  String? customerOtp;
  String? vehicleTypeId;
  String? categoryId;
  String? categoryQty;
  String? labourQty;
  String? labourPrice;
  String? stateStatus;
  String? statePrice;
  String? gst;
  String? tripOtp;
  String? fromLat;
  String? fromLong;
  String? fromAddress;
  String? toLat;
  String? toLong;
  String? toAddress;
  String? totalDistance;
  String? totalDuration;
  String? vehicleCharge;
  String? startSpeedometerText;
  String? startSpeedometerImage;
  String? endSpeedometerText;
  String? endSpeedometerImage;
  String? total;
  String? transactionId;
  String? paymentMode;
  String? paidAmt;
  String? rideTimeState;
  String? rideTime;
  String? rideDate;
  String? nearByPlace;
  String? pickupPoint;
  String? startTripStatus;
  String? ongoingStatus;
  String? pendingStatus;
  String? tripStatus;
  String? status;
  String? createdAt;
  String? updatedAt;

  TripDetails(
      {this.id,
        this.driverType,
        this.userId,
        this.driverId,
        this.startLoadingTime,
        this.endLoadingTime,
        this.startUnloadingTime,
        this.endUnloadingTime,
        this.startTripTime,
        this.endTripTime,
        this.customerName,
        this.customerMobile,
        this.customerVerifyStatus,
        this.customerOtp,
        this.vehicleTypeId,
        this.categoryId,
        this.categoryQty,
        this.labourQty,
        this.labourPrice,
        this.stateStatus,
        this.statePrice,
        this.gst,
        this.tripOtp,
        this.fromLat,
        this.fromLong,
        this.fromAddress,
        this.toLat,
        this.toLong,
        this.toAddress,
        this.totalDistance,
        this.totalDuration,
        this.vehicleCharge,
        this.startSpeedometerText,
        this.startSpeedometerImage,
        this.endSpeedometerText,
        this.endSpeedometerImage,
        this.total,
        this.transactionId,
        this.paymentMode,
        this.paidAmt,
        this.rideTimeState,
        this.rideTime,
        this.rideDate,
        this.nearByPlace,
        this.pickupPoint,
        this.startTripStatus,
        this.ongoingStatus,
        this.pendingStatus,
        this.tripStatus,
        this.status,
        this.createdAt,
        this.updatedAt});

  TripDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverType = json['driver_type'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    startLoadingTime = json['start_loading_time'];
    endLoadingTime = json['end_loading_time'];
    startUnloadingTime = json['start_unloading_time'];
    endUnloadingTime = json['end_unloading_time'];
    startTripTime = json['start_trip_time'];
    endTripTime = json['end_trip_time'];
    customerName = json['customer_name'];
    customerMobile = json['customer_mobile'];
    customerVerifyStatus = json['customer_verify_status'];
    customerOtp = json['customer_otp'];
    vehicleTypeId = json['vehicle_type_id'];
    categoryId = json['category_id'];
    categoryQty = json['category_qty'];
    labourQty = json['labour_qty'];
    labourPrice = json['labour_price'];
    stateStatus = json['state_status'];
    statePrice = json['state_price'];
    gst = json['gst'];
    tripOtp = json['trip_otp'];
    fromLat = json['from_lat'];
    fromLong = json['from_long'];
    fromAddress = json['from_address'];
    toLat = json['to_lat'];
    toLong = json['to_long'];
    toAddress = json['to_address'];
    totalDistance = json['total_distance'];
    totalDuration = json['total_duration'];
    vehicleCharge = json['vehicle_charge'];
    startSpeedometerText = json['start_speedometer_text'];
    startSpeedometerImage = json['start_speedometer_image'];
    endSpeedometerText = json['end_speedometer_text'];
    endSpeedometerImage = json['end_speedometer_image'];
    total = json['total'];
    transactionId = json['transaction_id'];
    paymentMode = json['payment_mode'];
    paidAmt = json['paid_amt'];
    rideTimeState = json['ride_time_state'];
    rideTime = json['ride_time'];
    rideDate = json['ride_date'];
    nearByPlace = json['near_by_place'];
    pickupPoint = json['pickup_point'];
    startTripStatus = json['start_trip_status'];
    ongoingStatus = json['ongoing_status'];
    pendingStatus = json['pending_status'];
    tripStatus = json['trip_status'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['Updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driver_type'] = this.driverType;
    data['user_id'] = this.userId;
    data['driver_id'] = this.driverId;
    data['start_loading_time'] = this.startLoadingTime;
    data['end_loading_time'] = this.endLoadingTime;
    data['start_unloading_time'] = this.startUnloadingTime;
    data['end_unloading_time'] = this.endUnloadingTime;
    data['start_trip_time'] = this.startTripTime;
    data['end_trip_time'] = this.endTripTime;
    data['customer_name'] = this.customerName;
    data['customer_mobile'] = this.customerMobile;
    data['customer_verify_status'] = this.customerVerifyStatus;
    data['customer_otp'] = this.customerOtp;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['category_id'] = this.categoryId;
    data['category_qty'] = this.categoryQty;
    data['labour_qty'] = this.labourQty;
    data['labour_price'] = this.labourPrice;
    data['state_status'] = this.stateStatus;
    data['state_price'] = this.statePrice;
    data['gst'] = this.gst;
    data['trip_otp'] = this.tripOtp;
    data['from_lat'] = this.fromLat;
    data['from_long'] = this.fromLong;
    data['from_address'] = this.fromAddress;
    data['to_lat'] = this.toLat;
    data['to_long'] = this.toLong;
    data['to_address'] = this.toAddress;
    data['total_distance'] = this.totalDistance;
    data['total_duration'] = this.totalDuration;
    data['vehicle_charge'] = this.vehicleCharge;
    data['start_speedometer_text'] = this.startSpeedometerText;
    data['start_speedometer_image'] = this.startSpeedometerImage;
    data['end_speedometer_text'] = this.endSpeedometerText;
    data['end_speedometer_image'] = this.endSpeedometerImage;
    data['total'] = this.total;
    data['transaction_id'] = this.transactionId;
    data['payment_mode'] = this.paymentMode;
    data['paid_amt'] = this.paidAmt;
    data['ride_time_state'] = this.rideTimeState;
    data['ride_time'] = this.rideTime;
    data['ride_date'] = this.rideDate;
    data['near_by_place'] = this.nearByPlace;
    data['pickup_point'] = this.pickupPoint;
    data['start_trip_status'] = this.startTripStatus;
    data['ongoing_status'] = this.ongoingStatus;
    data['pending_status'] = this.pendingStatus;
    data['trip_status'] = this.tripStatus;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['Updated_at'] = this.updatedAt;
    return data;
  }
}
