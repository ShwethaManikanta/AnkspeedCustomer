class OrderSpecificModel {
  String? status;
  String? message;
  String? vehicleBaseurl;
  OrderHistory? orderHistory;

  OrderSpecificModel(
      {this.status, this.message, this.vehicleBaseurl, this.orderHistory});

  OrderSpecificModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vehicleBaseurl = json['vehicle_baseurl'];
    orderHistory = json['order_history'] != null
        ? new OrderHistory.fromJson(json['order_history'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['vehicle_baseurl'] = this.vehicleBaseurl;
    if (this.orderHistory != null) {
      data['order_history'] = this.orderHistory!.toJson();
    }
    return data;
  }
}

class OrderHistory {
  String? id;
  String? bookType;
  String? customerOtp;
  TripDetails? tripDetails;
  String? goodTypeDetails;
  VechileDetails? vechileDetails;
  Null? driverDetails;
  String? customerName;
  String? customerMobile;
  String? bookedDate;
  String? orderLabel;
  String? orderStatus;

  OrderHistory(
      {this.id,
      this.bookType,
      this.customerOtp,
      this.tripDetails,
      this.goodTypeDetails,
      this.vechileDetails,
      this.driverDetails,
      this.customerName,
      this.customerMobile,
      this.bookedDate,
      this.orderLabel,
      this.orderStatus});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookType = json['book_type'];
    customerOtp = json['customer_otp'];
    tripDetails = json['trip_details'] != null
        ? new TripDetails.fromJson(json['trip_details'])
        : null;
    goodTypeDetails = json['good_type_details'];
    vechileDetails = json['vechile_details'] != null
        ? new VechileDetails.fromJson(json['vechile_details'])
        : null;
    driverDetails = json['driver_details'];
    customerName = json['customer_name'];
    customerMobile = json['customer_mobile'];
    bookedDate = json['booked_date'];
    orderLabel = json['order_label'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['book_type'] = this.bookType;
    data['customer_otp'] = this.customerOtp;
    if (this.tripDetails != null) {
      data['trip_details'] = this.tripDetails!.toJson();
    }
    data['good_type_details'] = this.goodTypeDetails;
    if (this.vechileDetails != null) {
      data['vechile_details'] = this.vechileDetails!.toJson();
    }
    data['driver_details'] = this.driverDetails;
    data['customer_name'] = this.customerName;
    data['customer_mobile'] = this.customerMobile;
    data['booked_date'] = this.bookedDate;
    data['order_label'] = this.orderLabel;
    data['order_status'] = this.orderStatus;
    return data;
  }
}

class TripDetails {
  String? id;
  String? driverType;
  String? userId;
  String? driverId;
  String? assignedDriverId;
  String? driverAssignTime;
  String? startLocationLat;
  String? startLocationLong;
  String? startLocationHeading;
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
  String? waitingCharge;
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
  String? driverCm;
  String? adminCm;
  String? transactionId;
  String? paymentMode;
  String? paidAmt;
  String? rideTimeState;
  String? rideTime;
  String? rideDate;
  String? nearByPlace;
  String? pickupPoint;
  String? cancelId;
  String? cancelText;
  String? startTripStatus;
  String? ongoingStatus;
  String? pendingStatus;
  String? tripStatus;
  String? paidStatus;
  String? status;
  String? cancelledUser;
  String? createdAt;
  String? updatedAt;

  TripDetails(
      {this.id,
      this.driverType,
      this.userId,
      this.driverId,
      this.assignedDriverId,
      this.driverAssignTime,
      this.startLocationLat,
      this.startLocationLong,
      this.startLocationHeading,
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
      this.waitingCharge,
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
      this.driverCm,
      this.adminCm,
      this.transactionId,
      this.paymentMode,
      this.paidAmt,
      this.rideTimeState,
      this.rideTime,
      this.rideDate,
      this.nearByPlace,
      this.pickupPoint,
      this.cancelId,
      this.cancelText,
      this.startTripStatus,
      this.ongoingStatus,
      this.pendingStatus,
      this.tripStatus,
      this.paidStatus,
      this.status,
      this.cancelledUser,
      this.createdAt,
      this.updatedAt});

  TripDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverType = json['driver_type'];
    userId = json['user_id'];
    driverId = json['driver_id'];
    assignedDriverId = json['assigned_driver_id'];
    driverAssignTime = json['driver_assign_time'];
    startLocationLat = json['start_location_lat'];
    startLocationLong = json['start_location_long'];
    startLocationHeading = json['start_location_heading'];
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
    waitingCharge = json['waiting_charge'];
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
    driverCm = json['driver_cm'];
    adminCm = json['admin_cm'];
    transactionId = json['transaction_id'];
    paymentMode = json['payment_mode'];
    paidAmt = json['paid_amt'];
    rideTimeState = json['ride_time_state'];
    rideTime = json['ride_time'];
    rideDate = json['ride_date'];
    nearByPlace = json['near_by_place'];
    pickupPoint = json['pickup_point'];
    cancelId = json['cancel_id'];
    cancelText = json['cancel_text'];
    startTripStatus = json['start_trip_status'];
    ongoingStatus = json['ongoing_status'];
    pendingStatus = json['pending_status'];
    tripStatus = json['trip_status'];
    paidStatus = json['paid_status'];
    status = json['status'];
    cancelledUser = json['cancelled_user'];
    createdAt = json['created_at'];
    updatedAt = json['Updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driver_type'] = this.driverType;
    data['user_id'] = this.userId;
    data['driver_id'] = this.driverId;
    data['assigned_driver_id'] = this.assignedDriverId;
    data['driver_assign_time'] = this.driverAssignTime;
    data['start_location_lat'] = this.startLocationLat;
    data['start_location_long'] = this.startLocationLong;
    data['start_location_heading'] = this.startLocationHeading;
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
    data['waiting_charge'] = this.waitingCharge;
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
    data['driver_cm'] = this.driverCm;
    data['admin_cm'] = this.adminCm;
    data['transaction_id'] = this.transactionId;
    data['payment_mode'] = this.paymentMode;
    data['paid_amt'] = this.paidAmt;
    data['ride_time_state'] = this.rideTimeState;
    data['ride_time'] = this.rideTime;
    data['ride_date'] = this.rideDate;
    data['near_by_place'] = this.nearByPlace;
    data['pickup_point'] = this.pickupPoint;
    data['cancel_id'] = this.cancelId;
    data['cancel_text'] = this.cancelText;
    data['start_trip_status'] = this.startTripStatus;
    data['ongoing_status'] = this.ongoingStatus;
    data['pending_status'] = this.pendingStatus;
    data['trip_status'] = this.tripStatus;
    data['paid_status'] = this.paidStatus;
    data['status'] = this.status;
    data['cancelled_user'] = this.cancelledUser;
    data['created_at'] = this.createdAt;
    data['Updated_at'] = this.updatedAt;
    return data;
  }
}

class VechileDetails {
  String? id;
  String? wheeler;
  String? stateId;
  String? pricePerKm;
  String? pricePerKmNg;
  String? dayTimeStart;
  String? nightTimeStart;
  String? kmFeesLimit;
  String? kmChargePerKm;
  String? otherStateCharge;
  String? waitingCharge;
  String? serviceCharge;
  String? chargeLimit;
  String? basicCharge;
  String? adminCm;
  String? tripKmLimit;
  String? image;
  String? capacity;
  String? size;
  String? description;
  String? paidShowStatus;
  String? payoutDays;
  String? status;
  String? createdAt;
  String? updatedAt;

  VechileDetails(
      {this.id,
      this.wheeler,
      this.stateId,
      this.pricePerKm,
      this.pricePerKmNg,
      this.dayTimeStart,
      this.nightTimeStart,
      this.kmFeesLimit,
      this.kmChargePerKm,
      this.otherStateCharge,
      this.waitingCharge,
      this.serviceCharge,
      this.chargeLimit,
      this.basicCharge,
      this.adminCm,
      this.tripKmLimit,
      this.image,
      this.capacity,
      this.size,
      this.description,
      this.paidShowStatus,
      this.payoutDays,
      this.status,
      this.createdAt,
      this.updatedAt});

  VechileDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wheeler = json['wheeler'];
    stateId = json['state_id'];
    pricePerKm = json['price_per_km'];
    pricePerKmNg = json['price_per_km_ng'];
    dayTimeStart = json['day_time_start'];
    nightTimeStart = json['night_time_start'];
    kmFeesLimit = json['km_fees_limit'];
    kmChargePerKm = json['km_charge_per_km'];
    otherStateCharge = json['other_state_charge'];
    waitingCharge = json['waiting_charge'];
    serviceCharge = json['service_charge'];
    chargeLimit = json['charge_limit'];
    basicCharge = json['basic_charge'];
    adminCm = json['admin_cm'];
    tripKmLimit = json['trip_km_limit'];
    image = json['image'];
    capacity = json['capacity'];
    size = json['size'];
    description = json['description'];
    paidShowStatus = json['paid_show_status'];
    payoutDays = json['payout_days'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wheeler'] = this.wheeler;
    data['state_id'] = this.stateId;
    data['price_per_km'] = this.pricePerKm;
    data['price_per_km_ng'] = this.pricePerKmNg;
    data['day_time_start'] = this.dayTimeStart;
    data['night_time_start'] = this.nightTimeStart;
    data['km_fees_limit'] = this.kmFeesLimit;
    data['km_charge_per_km'] = this.kmChargePerKm;
    data['other_state_charge'] = this.otherStateCharge;
    data['waiting_charge'] = this.waitingCharge;
    data['service_charge'] = this.serviceCharge;
    data['charge_limit'] = this.chargeLimit;
    data['basic_charge'] = this.basicCharge;
    data['admin_cm'] = this.adminCm;
    data['trip_km_limit'] = this.tripKmLimit;
    data['image'] = this.image;
    data['capacity'] = this.capacity;
    data['size'] = this.size;
    data['description'] = this.description;
    data['paid_show_status'] = this.paidShowStatus;
    data['payout_days'] = this.payoutDays;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
