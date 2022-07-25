class VehicleCategoriesResponseModel {
  String? status;
  String? message;
  String? vehicleBaseurl;
  ContactDetails? contactDetails;
  String? outerState;
  LabourDetails? labourDetails;
  List<VehicleList>? vehicleList;

  VehicleCategoriesResponseModel(
      {this.status,
      this.message,
      this.vehicleBaseurl,
      this.contactDetails,
      this.outerState,
      this.labourDetails,
      this.vehicleList});

  VehicleCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vehicleBaseurl = json['vehicle_baseurl'];
    contactDetails = json['contact_details'] != null
        ? new ContactDetails.fromJson(json['contact_details'])
        : null;
    outerState = json['outer_state'];
    labourDetails = json['labour_details'] != null
        ? new LabourDetails.fromJson(json['labour_details'])
        : null;
    if (json['vehicle_list'] != null) {
      vehicleList = <VehicleList>[];
      json['vehicle_list'].forEach((v) {
        vehicleList!.add(new VehicleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['vehicle_baseurl'] = this.vehicleBaseurl;
    if (this.contactDetails != null) {
      data['contact_details'] = this.contactDetails!.toJson();
    }
    data['outer_state'] = this.outerState;
    if (this.labourDetails != null) {
      data['labour_details'] = this.labourDetails!.toJson();
    }
    if (this.vehicleList != null) {
      data['vehicle_list'] = this.vehicleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContactDetails {
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

  ContactDetails(
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

  ContactDetails.fromJson(Map<String, dynamic> json) {
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

class LabourDetails {
  String? id;
  String? price;
  String? limit;
  String? status;
  String? createdAt;

  LabourDetails({this.id, this.price, this.limit, this.status, this.createdAt});

  LabourDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    limit = json['limit'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['limit'] = this.limit;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class VehicleList {
  String? id;
  String? wheeler;
  String? image;
  String? capacity;
  String? size;
  List<String>? description;
  String? pricePerKm;
  String? vehiclePrice;
  String? totalKm;
  String? time;
  String? labour;
  String? labourQty;
  String? labourTotal;
  String? gst;
  String? withoutGst;
  String? totalPrice;
  String? outerState;
  String? outerCharge;
  String? kmLimitStatus;

  VehicleList(
      {this.id,
      this.wheeler,
      this.image,
      this.capacity,
      this.size,
      this.description,
      this.pricePerKm,
      this.vehiclePrice,
      this.totalKm,
      this.time,
      this.labour,
      this.labourQty,
      this.labourTotal,
      this.gst,
      this.withoutGst,
      this.totalPrice,
      this.outerState,
      this.outerCharge,
      this.kmLimitStatus});

  VehicleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    wheeler = json['wheeler'];
    image = json['image'];
    capacity = json['capacity'];
    size = json['size'];
    description = json['description'].cast<String>();
    pricePerKm = json['price_per_km'];
    vehiclePrice = json['vehicle_price'];
    totalKm = json['total_km'];
    time = json['time'];
    labour = json['labour'];
    labourQty = json['labour_qty'];
    labourTotal = json['labour_total'];
    gst = json['gst'];
    withoutGst = json['without_gst'];
    totalPrice = json['total_price'];
    outerState = json['outer_state'];
    outerCharge = json['outer_charge'];
    kmLimitStatus = json['km_limit_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wheeler'] = this.wheeler;
    data['image'] = this.image;
    data['capacity'] = this.capacity;
    data['size'] = this.size;
    data['description'] = this.description;
    data['price_per_km'] = this.pricePerKm;
    data['vehicle_price'] = this.vehiclePrice;
    data['total_km'] = this.totalKm;
    data['time'] = this.time;
    data['labour'] = this.labour;
    data['labour_qty'] = this.labourQty;
    data['labour_total'] = this.labourTotal;
    data['gst'] = this.gst;
    data['without_gst'] = this.withoutGst;
    data['total_price'] = this.totalPrice;
    data['outer_state'] = this.outerState;
    data['outer_charge'] = this.outerCharge;
    data['km_limit_status'] = this.kmLimitStatus;
    return data;
  }
}
